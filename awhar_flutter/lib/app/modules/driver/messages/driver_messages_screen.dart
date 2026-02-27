import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../../core/controllers/request_controller.dart';
import '../../../../core/controllers/driver_store_delivery_controller.dart';
import '../../../../core/services/chat_service.dart';
import '../../../../core/utils/url_utils.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../core/controllers/conversations_controller.dart';

/// Driver messages screen showing direct chats and order-based conversations
class DriverMessagesScreen extends StatefulWidget {
  const DriverMessagesScreen({super.key});

  @override
  State<DriverMessagesScreen> createState() => _DriverMessagesScreenState();
}

class _DriverMessagesScreenState extends State<DriverMessagesScreen>
    with SingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final RequestController _requestController = Get.find<RequestController>();
  final ChatService _chatService = Get.find<ChatService>();

  late TabController _tabController;
  final List<DirectChatData> _directChats = [];
  bool _isLoadingDirectChats = true;
  StreamSubscription? _directChatsSubscription;
  bool _ordersRawLogged = false;
  final Map<String, DateTime> _orderLastActivity = {};

  /// Get or create DriverStoreDeliveryController
  DriverStoreDeliveryController get _storeDeliveryController {
    if (!Get.isRegistered<DriverStoreDeliveryController>()) {
      Get.put(DriverStoreDeliveryController());
    }
    return Get.find<DriverStoreDeliveryController>();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    debugPrint('[DriverMessages] 🚀 Screen initialized');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('[DriverMessages] ⏰ Post-frame callback triggered');
      _requestController.loadActiveRequest();
      _requestController.loadRequestHistory();
      _listenToDirectChats();
      _logOrdersRawConversations();
      _loadOrderLastActivity();
      // Load store delivery orders for the Store tab
      _storeDeliveryController.loadActiveDeliveries();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _directChatsSubscription?.cancel();
    super.dispose();
  }

  DateTime? _parseTimestamp(dynamic raw) {
    if (raw == null) return null;
    if (raw is int) {
      return DateTime.fromMillisecondsSinceEpoch(raw);
    }
    if (raw is String) {
      final parts = raw.split('::');
      final iso = parts.isNotEmpty ? parts.last : raw;
      return DateTime.tryParse(iso);
    }
    return null;
  }

  void _loadOrderLastActivity() {
    final dbInstance = _chatService.database;
    debugPrint(
      '[OrdersActivity] 📡 Computing last activity times from RTDB/chats',
    );
    dbInstance
        .ref('chats')
        .once()
        .then((event) {
          if (!event.snapshot.exists) {
            debugPrint('[OrdersActivity] ℹ️ No chats data');
            return;
          }
          final data = event.snapshot.value;
          if (data is! Map) {
            debugPrint(
              '[OrdersActivity] ⚠️ Unexpected chats payload type: ${data.runtimeType}',
            );
            return;
          }
          final Map<String, DateTime> computed = {};
          for (final entry in (data).entries) {
            final id = entry.key.toString();
            final v = entry.value;
            DateTime? latest;
            if (v is Map) {
              // ALWAYS scan messages timestamps to find the actual latest
              if (v['messages'] is Map) {
                final msgs = v['messages'] as Map;
                msgs.forEach((k, mv) {
                  if (mv is Map) {
                    final tsRaw =
                        mv['timestamp'] ??
                        mv['timestap'] ??
                        mv['time'] ??
                        mv['createdAt'] ??
                        mv['updatedAt'];
                    final d = _parseTimestamp(tsRaw);
                    if (d != null && (latest == null || d.isAfter(latest!))) {
                      latest = d;
                    }
                  }
                });
              }
              // Fallback to metadata if no messages found
              if (latest == null) {
                final lma = v['lastMessageAt'];
                final upd = v['updatedAt'];
                if (lma is int) {
                  latest = DateTime.fromMillisecondsSinceEpoch(lma);
                } else if (lma is String) {
                  final parts = lma.split('::');
                  latest = DateTime.tryParse(
                    parts.isNotEmpty ? parts.last : lma,
                  );
                }
                if (latest == null) {
                  if (upd is int) {
                    latest = DateTime.fromMillisecondsSinceEpoch(upd);
                  } else if (upd is String) {
                    final parts = upd.split('::');
                    latest = DateTime.tryParse(
                      parts.isNotEmpty ? parts.last : upd,
                    );
                  }
                }
              }
            }
            if (latest != null) {
              computed[id] = latest!;
              debugPrint(
                '[OrdersActivity] ⏱️ requestId=$id lastActivity=${latest!.toIso8601String()}',
              );
            } else {
              debugPrint(
                '[OrdersActivity] ⏱️ requestId=$id has no activity timestamp, will fallback to createdAt',
              );
            }
          }
          setState(() {
            _orderLastActivity
              ..clear()
              ..addAll(computed);
          });
          debugPrint(
            '[OrdersActivity] ✅ Computed lastActivity for ${_orderLastActivity.length} chats',
          );
        })
        .catchError((e) {
          debugPrint('[OrdersActivity] ❌ Failed to compute last activity: $e');
        });
  }

  void _logOrdersRawConversations() {
    if (_ordersRawLogged) return;
    final driverId = _authController.currentUser.value?.id?.toString();
    final dbInstance = _chatService.database;
    debugPrint('[OrdersRaw] 📡 Fetching raw orders conversations from RTDB');
    dbInstance
        .ref('chats')
        .once()
        .then((event) {
          debugPrint('[OrdersRaw] ✅ Snapshot exists: ${event.snapshot.exists}');
          if (!event.snapshot.exists) {
            _ordersRawLogged = true;
            return;
          }
          final data = event.snapshot.value;
          debugPrint('[OrdersRaw] 🧾 Full raw JSON: ${data}');
          if (data is Map) {
            int total = 0;
            int forDriver = 0;
            for (final e in data.entries) {
              total++;
              final v = e.value;
              if (v is Map) {
                final chatDriverId = v['driverId']?.toString();
                if (driverId != null && chatDriverId == driverId) {
                  forDriver++;
                }
              }
            }
            debugPrint(
              '[OrdersRaw] 📊 Counts: total=$total, forDriver=$forDriver',
            );
          }
          _ordersRawLogged = true;
        })
        .catchError((e) {
          debugPrint('[OrdersRaw] ❌ Failed to fetch raw conversations: $e');
          _ordersRawLogged = true;
        });
  }

  void _listenToDirectChats() async {
    debugPrint('[DriverMessages] 🎧 Setting up direct chats listener...');

    final driverId = _authController.currentUser.value?.id.toString();
    debugPrint('[DriverMessages] 👤 Driver ID: $driverId');

    if (driverId == null) {
      debugPrint('[DriverMessages] ❌ Driver ID is null');
      setState(() => _isLoadingDirectChats = false);
      return;
    }

    debugPrint(
      '[DriverMessages] 🔐 Firebase Auth user: ${FirebaseAuth.instance.currentUser?.uid ?? "NOT LOGGED IN"}',
    );

    // Always wait for Firebase Auth to ensure token is propagated to Database
    debugPrint('[DriverMessages] ⏳ Ensuring Firebase Auth token is ready...');
    try {
      // Wait for auth state with timeout
      await FirebaseAuth.instance.authStateChanges().first.timeout(
        const Duration(seconds: 2),
      );
      // Small additional delay to ensure token propagates to Database
      await Future.delayed(const Duration(milliseconds: 300));
      debugPrint('[DriverMessages] ✅ Firebase Auth token ready');
    } catch (e) {
      debugPrint(
        '[DriverMessages] ⚠️ Auth wait timeout (will proceed anyway): $e',
      );
    }

    // Use ChatService's configured Firebase Database (regional URL)
    final dbInstance = _chatService.database;
    debugPrint('[DriverMessages] 🗄️ Database instance: $dbInstance');
    debugPrint('[DriverMessages] 🌐 Database URL: ${dbInstance.databaseURL}');

    // Test basic connectivity with root read
    debugPrint('[DriverMessages] 🧪 Testing root connectivity...');
    dbInstance
        .ref('.info/connected')
        .once()
        .then((event) {
          debugPrint(
            '[DriverMessages] ✅ Connection test: ${event.snapshot.value}',
          );
        })
        .catchError((e) {
          debugPrint('[DriverMessages] ❌ Connection test failed: $e');
        });

    // Listen to direct_chats in real-time
    final directChatsRef = dbInstance.ref('direct_chats');
    debugPrint(
      '[DriverMessages] 📡 Starting real-time listener for direct_chats',
    );
    debugPrint('[DriverMessages] 📍 Ref path: ${directChatsRef.path}');
    debugPrint('[DriverMessages] 🔗 Full URL: ${directChatsRef.toString()}');

    // Test if we can read at all with a shorter timeout
    debugPrint('[DriverMessages] 🧪 Testing direct_chats read with once()...');
    directChatsRef
        .once()
        .timeout(
          const Duration(seconds: 3),
          onTimeout: () {
            debugPrint(
              '[DriverMessages] ⏱️ Once() timeout - permission denied or no data',
            );
            throw TimeoutException('Read timeout');
          },
        )
        .then((event) {
          debugPrint('[DriverMessages] ✅ Once() succeeded!');
          debugPrint(
            '[DriverMessages] 📦 Data exists: ${event.snapshot.exists}',
          );
          if (event.snapshot.exists) {
            debugPrint('[DriverMessages] 📊 Data: ${event.snapshot.value}');
          }
        })
        .catchError((error) {
          debugPrint('[DriverMessages] ❌ Once() failed: $error');
        });

    _directChatsSubscription = directChatsRef.onValue.listen(
      (event) {
        debugPrint('[DriverMessages] 📨 Received data event');
        debugPrint(
          '[DriverMessages] 📦 Snapshot exists: ${event.snapshot.exists}',
        );
        debugPrint('[DriverMessages] 🔑 Snapshot key: ${event.snapshot.key}');

        final List<DirectChatData> chats = [];

        if (event.snapshot.exists) {
          try {
            final data = event.snapshot.value;
            debugPrint(
              '[DriverMessages] 📦 Data exists, type: ${data.runtimeType}',
            );
            debugPrint('[DriverMessages] 🧾 Raw direct_chats JSON: $data');

            if (data is Map) {
              debugPrint(
                '[DriverMessages] 📊 Processing ${data.length} total chats',
              );

              for (final entry in data.entries) {
                try {
                  final chatId = entry.key.toString();

                  if (entry.value is! Map) continue;

                  final chatData = entry.value as Map<dynamic, dynamic>;
                  final chatDriverId = chatData['driverId']?.toString();
                  final clientIdStr = chatData['clientId']?.toString() ?? '';

                  // Only include chats where this driver is a participant
                  if (chatDriverId != driverId) continue;

                  debugPrint(
                    '[DriverMessages] ✅ Found chat for driver: $chatId',
                  );

                  // Parse lastMessage (could be object or string)
                  String lastMessageText = '';
                  if (chatData['lastMessage'] != null) {
                    if (chatData['lastMessage'] is String) {
                      lastMessageText = chatData['lastMessage'] as String;
                    } else if (chatData['lastMessage'] is Map) {
                      final msgMap = chatData['lastMessage'] as Map;
                      lastMessageText = msgMap['text']?.toString() ?? '';
                    }
                  }

                  // Determine avatar: prefer stored clientAvatar, then fall back to:
                  // 1) lastMessage.senderAvatar (if lastMessage is an object)
                  // 2) latest entry in messages[].senderAvatar for the client
                  String? avatarUrl = chatData['clientAvatar']?.toString();
                  if (avatarUrl == null || avatarUrl.isEmpty) {
                    final lm = chatData['lastMessage'];
                    if (lm is Map) {
                      final senderId = lm['senderId']?.toString();
                      final senderAvatar = lm['senderAvatar']?.toString();
                      if (senderId != null &&
                          senderId == clientIdStr &&
                          senderAvatar != null &&
                          senderAvatar.isNotEmpty) {
                        avatarUrl = senderAvatar;
                        debugPrint(
                          '[DriverMessages] 👤 Using fallback avatar from lastMessage (object) for chat $chatId',
                        );
                      }
                    }

                    // If still no avatar and we have messages, inspect the latest message from the client
                    if ((avatarUrl == null || avatarUrl.isEmpty) &&
                        chatData['messages'] is Map) {
                      final msgs =
                          chatData['messages'] as Map<dynamic, dynamic>;
                      DateTime? latestTs;
                      String? latestClientAvatar;
                      msgs.forEach((key, value) {
                        if (value is Map) {
                          final senderId = value['senderId']?.toString();
                          final senderAvatar = value['senderAvatar']
                              ?.toString();
                          // Robust timestamp parsing supporting 'timestap::...'
                          final rawTs =
                              value['timestamp'] ??
                              value['timestap'] ??
                              value['time'] ??
                              value['createdAt'] ??
                              value['updatedAt'];
                          final ts = _parseTimestamp(rawTs);

                          if (senderId == clientIdStr &&
                              senderAvatar != null &&
                              senderAvatar.isNotEmpty) {
                            if (ts != null &&
                                (latestTs == null || ts.isAfter(latestTs!))) {
                              latestTs = ts;
                              latestClientAvatar = senderAvatar;
                            }
                          }
                        }
                      });

                      if (latestClientAvatar?.isNotEmpty == true) {
                        avatarUrl = latestClientAvatar;
                        debugPrint(
                          '[DriverMessages] 👤 Using fallback avatar from latest messages entry for chat $chatId',
                        );
                      }
                    }
                  }
                  final normalizedAvatar = UrlUtils.normalizeImageUrl(
                    avatarUrl,
                  );
                  debugPrint(
                    '[DriverMessages] 👤 Avatar for chat $chatId: raw="${avatarUrl ?? ''}" normalized="${normalizedAvatar ?? avatarUrl ?? ''}"',
                  );

                  // Compute lastMessageAt robustly
                  DateTime lastMsgAt;
                  final rawLastAt = chatData['lastMessageAt'];
                  final parsedLastAt = _parseTimestamp(rawLastAt);
                  if (parsedLastAt != null) {
                    lastMsgAt = parsedLastAt;
                  } else if (chatData['lastMessage'] is Map) {
                    final lm = chatData['lastMessage'] as Map;
                    final lmTsRaw =
                        lm['timestamp'] ??
                        lm['timestap'] ??
                        lm['updatedAt'] ??
                        lm['time'] ??
                        lm['createdAt'];
                    lastMsgAt = _parseTimestamp(lmTsRaw) ?? DateTime.now();
                  } else {
                    lastMsgAt = DateTime.now();
                  }

                  chats.add(
                    DirectChatData(
                      chatId: chatId,
                      clientId: chatData['clientId']?.toString() ?? '',
                      clientName:
                          chatData['clientName']?.toString() ?? 'Client',
                      clientAvatar: avatarUrl,
                      lastMessage: lastMessageText.isEmpty
                          ? 'No messages yet'
                          : lastMessageText,
                      lastMessageAt: lastMsgAt,
                      unreadCount: chatData['unreadCount'] is Map
                          ? (chatData['unreadCount'][driverId] as int? ?? 0)
                          : 0,
                    ),
                  );
                } catch (e) {
                  debugPrint('[DriverMessages] ⚠️ Error parsing chat: $e');
                }
              }
            }

            // Sort by most recent
            chats.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));

            debugPrint(
              '[DriverMessages] ✅ Loaded ${chats.length} direct chats',
            );
          } catch (e) {
            debugPrint('[DriverMessages] ❌ Error processing data: $e');
          }
        } else {
          debugPrint('[DriverMessages] ℹ️ No direct_chats data exists');
        }

        setState(() {
          _directChats.clear();
          _directChats.addAll(chats);
          _isLoadingDirectChats = false;
        });
      },
      onError: (error) {
        debugPrint('[DriverMessages] ❌ Stream error: $error');
        setState(() => _isLoadingDirectChats = false);
      },
    );
  }

  Future<void> _refreshDirectChats() async {
    debugPrint('[DriverMessages] 🔄 Manual refresh triggered');
    // The stream will automatically update
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('messages.title'.tr),
        backgroundColor: colors.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: colors.primary,
          unselectedLabelColor: colors.textSecondary,
          indicatorColor: colors.primary,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.message_text, size: 18.sp),
                  SizedBox(width: 8.w),
                  Text('Direct'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.receipt_1, size: 18.sp),
                  SizedBox(width: 8.w),
                  Text('Orders'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.shop, size: 18.sp),
                  SizedBox(width: 8.w),
                  Text('Store'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDirectChatsTab(colors),
          _buildOrderChatsTab(colors),
          _buildStoreOrdersTab(colors),
        ],
      ),
    );
  }

  Widget _buildDirectChatsTab(AppColorScheme colors) {
    if (_isLoadingDirectChats) {
      return Center(
        child: CircularProgressIndicator(color: colors.primary),
      );
    }

    if (_directChats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.message,
              size: 64.sp,
              color: colors.textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              'No direct messages yet',
              style: AppTypography.bodyMedium(
                context,
              ).copyWith(color: colors.textSecondary),
            ),
            SizedBox(height: 8.h),
            Text(
              'Clients can message you from your profile',
              style: AppTypography.bodySmall(
                context,
              ).copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshDirectChats,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: _directChats.length,
        itemBuilder: (context, index) {
          final chat = _directChats[index];
          return _DirectChatCard(
            colors: colors,
            chat: chat,
            onTap: () async {
              Get.toNamed(
                '/direct-chat',
                arguments: {
                  'clientId': chat.clientId,
                  'clientName': chat.clientName,
                  'clientAvatar': chat.clientAvatar,
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderChatsTab(AppColorScheme colors) {
    final currentUserId =
        _authController.currentUser.value?.id?.toString() ?? '';
    final conv = Get.find<ConversationsController>();
    return Obx(() {
      // Merge active + history requests to show all conversations
      final merged = <ServiceRequest>[];
      merged.addAll(_requestController.activeRequests);
      merged.addAll(_requestController.requestHistory);
      // Deduplicate by request id
      final seen = <int>{};
      final requests = <ServiceRequest>[];
      for (final r in merged) {
        final id = r.id ?? -1;
        if (!seen.contains(id)) {
          seen.add(id);
          requests.add(r);
        }
      }
      // Sort by latest message/activity desc, prefer ConversationsController
      DateTime _activityFor(ServiceRequest r) {
        final key = (r.id ?? -1).toString();
        return conv.lastActivityByRequestId[key] ??
            _orderLastActivity[key] ??
            r.createdAt;
      }

      requests.sort((a, b) => _activityFor(b).compareTo(_activityFor(a)));
      if (requests.isNotEmpty) {
        debugPrint(
          '[OrdersList] 🔢 Showing ${requests.length} orders, first=${requests.first.id} at ${_activityFor(requests.first).toIso8601String()}',
        );
      }

      if (_requestController.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: colors.primary));
      }

      if (requests.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.receipt_1,
                size: 64.sp,
                color: colors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                'No active orders',
                style: AppTypography.bodyMedium(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
              SizedBox(height: 8.h),
              Text(
                'You will see ongoing requests here',
                style: AppTypography.bodySmall(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final req = requests[index];
          final key = (req.id ?? -1).toString();
          final lastActivity =
              conv.lastActivityByRequestId[key] ?? _orderLastActivity[key];
          debugPrint(
            '[OrdersList] ▶️ item requestId=${req.id} time=${(lastActivity ?? req.createdAt).toIso8601String()} (source=${lastActivity != null ? 'conv/orderLastActivity' : 'createdAt'})',
          );
          return _OrderConversationCard(
            colors: colors,
            request: req,
            chatService: _chatService,
            currentUserId: currentUserId,
            lastActivity: lastActivity,
          );
        },
      );
    });
  }

  /// Build Store Orders tab - shows store delivery orders assigned to this driver
  Widget _buildStoreOrdersTab(AppColorScheme colors) {
    return Obx(() {
      final controller = _storeDeliveryController;

      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: colors.primary),
        );
      }

      // Show both active and completed deliveries in the messages tab
      final orders = <StoreOrder>[
        ...controller.activeDeliveries,
        ...controller.completedDeliveries,
      ];

      if (orders.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.shop,
                size: 64.sp,
                color: colors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                'store_orders.no_orders'.tr.isEmpty
                    ? 'No store deliveries'
                    : 'store_orders.no_orders'.tr,
                style: AppTypography.bodyMedium(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
              SizedBox(height: 8.h),
              Text(
                'Accepted store delivery orders will appear here',
                style: AppTypography.bodySmall(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async => controller.refresh(),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return _DriverStoreOrderCard(
              colors: colors,
              order: order,
              onTap: () {
                // Navigate to the store order group chat
                Get.toNamed(
                  '/store-order-chat',
                  arguments: {
                    'orderId': order.id,
                    'userRole': 'driver',
                  },
                );
              },
            );
          },
        ),
      );
    });
  }
}

// Direct chat data model
class DirectChatData {
  final String chatId;
  final String clientId;
  final String clientName;
  final String? clientAvatar;
  final String lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;

  DirectChatData({
    required this.chatId,
    required this.clientId,
    required this.clientName,
    this.clientAvatar,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
  });
}

// Direct chat card widget
class _DirectChatCard extends StatelessWidget {
  final AppColorScheme colors;
  final DirectChatData chat;
  final VoidCallback onTap;

  const _DirectChatCard({
    required this.colors,
    required this.chat,
    required this.onTap,
  });

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'Now';
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = chat.unreadCount > 0;
    final rawAvatar = chat.clientAvatar;
    final normalized = UrlUtils.normalizeImageUrl(rawAvatar ?? '');
    debugPrint(
      '[DriverMessages] 🖼️ Building card avatar: chatId=${chat.chatId}, raw="${rawAvatar ?? ''}", normalized="${normalized ?? rawAvatar ?? ''}"',
    );

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: hasUnread ? colors.primary.withOpacity(0.05) : null,
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: (rawAvatar != null && rawAvatar.isNotEmpty)
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                UrlUtils.normalizeImageUrl(rawAvatar) ??
                                rawAvatar,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                              Iconsax.user,
                              color: colors.primary,
                              size: 24.sp,
                            ),
                          ),
                        )
                      : Icon(
                          Iconsax.user,
                          color: colors.primary,
                          size: 24.sp,
                        ),
                ),
                // Online indicator
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      color: colors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.background, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          chat.clientName,
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: hasUnread
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTime(chat.lastMessageAt),
                        style: AppTypography.bodySmall(context).copyWith(
                          color: hasUnread
                              ? colors.primary
                              : colors.textSecondary,
                          fontWeight: hasUnread
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          style: AppTypography.bodySmall(context).copyWith(
                            color: hasUnread
                                ? colors.textPrimary
                                : colors.textSecondary,
                            fontWeight: hasUnread
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: AppTypography.bodySmall(context).copyWith(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // Arrow icon
            Icon(
              Icons.chevron_right,
              color: colors.textSecondary,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}

// Order conversation card widget
class _OrderConversationCard extends StatefulWidget {
  final AppColorScheme colors;
  final ServiceRequest request;
  final ChatService chatService;
  final String currentUserId;
  final DateTime? lastActivity;

  const _OrderConversationCard({
    required this.colors,
    required this.request,
    required this.chatService,
    required this.currentUserId,
    this.lastActivity,
  });

  @override
  State<_OrderConversationCard> createState() => _OrderConversationCardState();
}

class _OrderConversationCardState extends State<_OrderConversationCard> {
  String? _clientAvatarUrl;
  DateTime? _displayTime;

  @override
  void initState() {
    super.initState();
    _fetchClientAvatar();
    _loadLatestMessageTime();
  }

  /// Fetch the latest message time directly from RTDB messages
  Future<void> _loadLatestMessageTime() async {
    try {
      final reqId = widget.request.id?.toString() ?? '';
      if (reqId.isEmpty) {
        setState(() => _displayTime = widget.request.createdAt);
        return;
      }
      debugPrint(
        '[OrderCard] ⏱️ Loading latest message time for requestId=$reqId',
      );
      final latestMsgTime = await widget.chatService.getLatestMessageTime(
        reqId,
      );
      final chosen =
          latestMsgTime ?? widget.lastActivity ?? widget.request.createdAt;
      debugPrint(
        '[OrderCard] ⏱️ requestId=$reqId latestMsgTime=${latestMsgTime?.toIso8601String()} lastActivity=${widget.lastActivity?.toIso8601String()} chosen=${chosen.toIso8601String()}',
      );
      if (mounted) {
        setState(() => _displayTime = chosen);
      }
    } catch (e) {
      debugPrint('[OrderCard] ❌ Failed to load latest message time: $e');
      if (mounted) {
        setState(
          () => _displayTime = widget.lastActivity ?? widget.request.createdAt,
        );
      }
    }
  }

  Future<void> _fetchClientAvatar() async {
    try {
      final clientId = widget.request.clientId;
      debugPrint(
        '[OrderCard] 🔎 Fetching client avatar for clientId=$clientId, requestId=${widget.request.id}',
      );
      final client = Get.find<Client>();
      final res = await client.user.getUserById(userId: clientId);
      final rawUrl = res.user?.profilePhotoUrl;
      final normalized = UrlUtils.normalizeImageUrl(rawUrl ?? '');
      debugPrint(
        '[OrderCard] 🖼️ Avatar fetched: raw="${rawUrl ?? ''}", normalized="${normalized ?? rawUrl ?? ''}"',
      );
      setState(() {
        _clientAvatarUrl = normalized ?? rawUrl;
      });
    } catch (e) {
      debugPrint('[OrderCard] ❌ Failed to fetch client avatar: $e');
    }
  }

  String _getStatusLabel() {
    switch (widget.request.status) {
      case RequestStatus.pending:
        return 'Pending';
      case RequestStatus.driver_proposed:
        return 'Proposed';
      case RequestStatus.accepted:
      case RequestStatus.driver_arriving:
        return 'Active';
      case RequestStatus.in_progress:
        return 'In Progress';
      case RequestStatus.completed:
        return 'Completed';
      case RequestStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getStatusColor() {
    switch (widget.request.status) {
      case RequestStatus.pending:
        return widget.colors.warning;
      case RequestStatus.driver_proposed:
        return widget.colors.info;
      case RequestStatus.accepted:
      case RequestStatus.driver_arriving:
      case RequestStatus.in_progress:
        return widget.colors.success;
      case RequestStatus.completed:
        return widget.colors.textSecondary;
      case RequestStatus.cancelled:
        return widget.colors.error;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'Now';
  }

  @override
  Widget build(BuildContext context) {
    final isActive =
        widget.request.status != RequestStatus.completed &&
        widget.request.status != RequestStatus.cancelled;
    final displayTime =
        _displayTime ?? widget.lastActivity ?? widget.request.createdAt;
    debugPrint(
      '[OrderCard] 🎨 Rendering requestId=${widget.request.id} displayTime=${displayTime.toIso8601String()} (_displayTime=${_displayTime?.toIso8601String()}, lastActivity=${widget.lastActivity?.toIso8601String()}, createdAt=${widget.request.createdAt.toIso8601String()})',
    );

    return InkWell(
      onTap: () {
        Get.toNamed('/chat/${widget.request.id}', arguments: widget.request);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isActive ? widget.colors.primary.withOpacity(0.05) : null,
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: widget.colors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Builder(
                    builder: (context) {
                      final raw = _clientAvatarUrl;
                      final normalized = UrlUtils.normalizeImageUrl(raw ?? '');
                      debugPrint(
                        '[OrderCard] 🧱 Building avatar: requestId=${widget.request.id}, raw="${raw ?? ''}", normalized="${normalized ?? raw ?? ''}"',
                      );
                      if (raw != null && raw.isNotEmpty) {
                        return ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: normalized ?? raw,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                              Iconsax.user,
                              color: widget.colors.primary,
                              size: 24.sp,
                            ),
                          ),
                        );
                      }
                      return Icon(
                        Iconsax.user,
                        color: widget.colors.primary,
                        size: 24.sp,
                      );
                    },
                  ),
                ),
                // Status indicator
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      color: _getStatusColor(),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.colors.background,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.request.clientName,
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: widget.colors.textPrimary,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTime(displayTime),
                        style: AppTypography.bodySmall(context).copyWith(
                          color: isActive
                              ? widget.colors.primary
                              : widget.colors.textSecondary,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ORD-${widget.request.id} • ${_getStatusLabel()}',
                          style: AppTypography.bodySmall(context).copyWith(
                            color: isActive
                                ? widget.colors.textPrimary
                                : widget.colors.textSecondary,
                            fontWeight: isActive
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Unread indicator for active chats
                      if (isActive)
                        StreamBuilder<int>(
                          stream: widget.chatService.listenToUnreadCount(
                            widget.request.id.toString(),
                            widget.currentUserId,
                          ),
                          builder: (context, snapshot) {
                            final unread = snapshot.data ?? 0;
                            if (unread == 0) return const SizedBox.shrink();

                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: widget.colors.primary,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                unread.toString(),
                                style: AppTypography.bodySmall(context)
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // Arrow icon
            Icon(
              Icons.chevron_right,
              color: widget.colors.textSecondary,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}

/// Card widget for driver's store order in the messages list
class _DriverStoreOrderCard extends StatelessWidget {
  final AppColorScheme colors;
  final StoreOrder order;
  final VoidCallback onTap;

  const _DriverStoreOrderCard({
    required this.colors,
    required this.order,
    required this.onTap,
  });

  String _getStatusText(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return 'Pending';
      case StoreOrderStatus.confirmed:
        return 'Confirmed';
      case StoreOrderStatus.preparing:
        return 'Preparing';
      case StoreOrderStatus.ready:
        return 'Ready for Pickup';
      case StoreOrderStatus.driverAssigned:
        return 'Assigned to You';
      case StoreOrderStatus.pickedUp:
        return 'Picked Up';
      case StoreOrderStatus.inDelivery:
        return 'In Delivery';
      case StoreOrderStatus.delivered:
        return 'Delivered';
      case StoreOrderStatus.cancelled:
        return 'Cancelled';
      case StoreOrderStatus.rejected:
        return 'Rejected';
    }
  }

  Color _getStatusColor(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return Colors.orange;
      case StoreOrderStatus.confirmed:
        return Colors.blue;
      case StoreOrderStatus.preparing:
        return Colors.purple;
      case StoreOrderStatus.ready:
        return Colors.teal;
      case StoreOrderStatus.driverAssigned:
        return Colors.indigo;
      case StoreOrderStatus.pickedUp:
        return Colors.cyan;
      case StoreOrderStatus.inDelivery:
        return Colors.green;
      case StoreOrderStatus.delivered:
        return Colors.green;
      case StoreOrderStatus.cancelled:
        return Colors.red;
      case StoreOrderStatus.rejected:
        return Colors.red;
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dateTime.day}/${dateTime.month}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive =
        order.status != StoreOrderStatus.delivered &&
        order.status != StoreOrderStatus.cancelled &&
        order.status != StoreOrderStatus.rejected;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isActive ? colors.primary.withOpacity(0.3) : colors.border,
          ),
        ),
        child: Row(
          children: [
            // Store icon with delivery indicator
            Stack(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: isActive
                        ? colors.primary.withOpacity(0.1)
                        : colors.textSecondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Iconsax.shop,
                    color: isActive ? colors.primary : colors.textSecondary,
                    size: 24.sp,
                  ),
                ),
                // Active delivery indicator
                if (isActive)
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.background, width: 2),
                      ),
                      child: Icon(
                        Iconsax.truck,
                        color: Colors.white,
                        size: 10.sp,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            // Order details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          order.orderNumber,
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: isActive
                                ? colors.textPrimary
                                : colors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol),
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: isActive
                              ? colors.primary
                              : colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          _getStatusText(order.status),
                          style: AppTypography.bodySmall(context).copyWith(
                            color: _getStatusColor(order.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _formatDate(order.createdAt),
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  // Delivery address hint
                  if (order.deliveryAddress != null && isActive) ...[
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 12.sp,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            order.deliveryAddress!,
                            style: AppTypography.bodySmall(context).copyWith(
                              color: colors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Chat icon + arrow
            Column(
              children: [
                Icon(
                  Iconsax.message,
                  color: isActive ? colors.primary : colors.textSecondary,
                  size: 20.sp,
                ),
                SizedBox(height: 4.h),
                Icon(
                  Icons.chevron_right,
                  color: colors.textSecondary,
                  size: 24.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
