import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/controllers/auth_controller.dart';
import '../../../core/controllers/request_controller.dart';
import '../../../core/services/chat_service.dart';
import '../../../core/controllers/conversations_controller.dart';
import '../../../core/controllers/client_store_order_controller.dart';
import '../../../core/controllers/store_order_controller.dart';
import '../home/home_controller.dart';
import '../../../core/utils/url_utils.dart';
import '../../../core/utils/currency_helper.dart';

/// Messages screen showing real conversations from requests and direct chats
/// Role-aware: Shows different tabs based on user role
/// - Client: Direct, Orders (service requests), Store Orders
/// - Store: Direct, Store Orders (incoming orders)
/// - Driver: Direct, Orders (service requests)
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final RequestController _requestController = Get.find<RequestController>();
  final ChatService _chatService = Get.find<ChatService>();

  late TabController _tabController;
  final List<DirectChatData> _directChats = [];
  bool _isLoadingDirectChats = true;

  /// Get user's current role mode
  bool get _isStoreMode {
    if (Get.isRegistered<HomeController>()) {
      return Get.find<HomeController>().isStoreMode;
    }
    return _authController.currentUser.value?.roles.contains(UserRole.store) ??
        false;
  }

  bool get _isDriverMode {
    if (Get.isRegistered<HomeController>()) {
      return Get.find<HomeController>().isDriverMode;
    }
    return _authController.currentUser.value?.roles.contains(UserRole.driver) ??
        false;
  }

  /// Get tab count based on role
  int get _tabCount {
    if (_isStoreMode) return 2; // Direct, Store Orders
    if (_isDriverMode) return 2; // Direct, Orders
    return 3; // Client: Direct, Orders, Store
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabCount, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load data based on role
      if (!_isStoreMode) {
        _requestController.loadActiveRequest();
        _requestController.loadRequestHistory();
      }
      _listenToDirectChats();

      // Refresh store orders based on role
      if (_isStoreMode) {
        // Store role: refresh their incoming orders
        if (Get.isRegistered<StoreOrderController>()) {
          Get.find<StoreOrderController>().refresh();
        }
      } else {
        // Client role: refresh their store orders
        if (Get.isRegistered<ClientStoreOrdersController>()) {
          Get.find<ClientStoreOrdersController>().refresh();
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _listenToDirectChats() async {
    final clientId = _authController.currentUser.value?.id?.toString();
    if (clientId == null) return;

    // Always wait for Firebase Auth to ensure token is propagated to Database
    debugPrint('[ClientMessages] ⏳ Ensuring Firebase Auth token is ready...');
    try {
      // Wait for auth state with timeout
      await FirebaseAuth.instance.authStateChanges().first.timeout(
        const Duration(seconds: 2),
      );
      // Small additional delay to ensure token propagates to Database
      await Future.delayed(const Duration(milliseconds: 300));
      debugPrint('[ClientMessages] ✅ Firebase Auth token ready');
    } catch (e) {
      debugPrint(
        '[ClientMessages] ⚠️ Auth wait timeout (will proceed anyway): $e',
      );
    }

    final dbInstance = _chatService.database;
    debugPrint('[ClientMessages] 📡 Listening to direct_chats');

    dbInstance
        .ref('direct_chats')
        .onValue
        .listen(
          (event) {
            final chats = <DirectChatData>[];

            if (event.snapshot.value is Map) {
              final data = event.snapshot.value as Map<dynamic, dynamic>;

              for (final entry in data.entries) {
                try {
                  final chatId = entry.key.toString();
                  if (entry.value is! Map) continue;

                  final chatData = entry.value as Map<dynamic, dynamic>;
                  final driverIdStr = chatData['driverId']?.toString() ?? '';
                  final clientIdData = chatData['clientId']?.toString() ?? '';

                  // Only include chats where this client is a participant
                  if (clientIdData != clientId) continue;

                  debugPrint(
                    '[ClientMessages] ✅ Found chat for client: $chatId',
                  );

                  // Parse lastMessage
                  String lastMessageText = '';
                  if (chatData['lastMessage'] != null) {
                    if (chatData['lastMessage'] is String) {
                      lastMessageText = chatData['lastMessage'] as String;
                    } else if (chatData['lastMessage'] is Map) {
                      final msgMap = chatData['lastMessage'] as Map;
                      lastMessageText = msgMap['text']?.toString() ?? '';
                    }
                  }

                  // Get driver avatar with fallback chain
                  String? avatarUrl = chatData['driverAvatar']?.toString();

                  // Fallback 1: Try lastMessage (object) senderAvatar
                  if (avatarUrl == null || avatarUrl.isEmpty) {
                    final lm = chatData['lastMessage'];
                    if (lm is Map) {
                      final senderId = lm['senderId']?.toString();
                      final senderAvatar = lm['senderAvatar']?.toString();
                      if (senderId == driverIdStr &&
                          senderAvatar != null &&
                          senderAvatar.isNotEmpty) {
                        avatarUrl = senderAvatar;
                        debugPrint(
                          '[ClientMessages] 👤 Using fallback avatar from lastMessage (object) for chat $chatId',
                        );
                      }
                    }
                  }

                  // Fallback 2: Scan messages for latest driver's sender avatar
                  if ((avatarUrl == null || avatarUrl.isEmpty) &&
                      chatData['messages'] is Map) {
                    final msgs = chatData['messages'] as Map<dynamic, dynamic>;
                    String? latestDriverAvatar;
                    msgs.forEach((key, value) {
                      if (value is Map) {
                        final senderId = value['senderId']?.toString();
                        final senderAvatar = value['senderAvatar']?.toString();
                        if (senderId == driverIdStr &&
                            senderAvatar != null &&
                            senderAvatar.isNotEmpty) {
                          latestDriverAvatar = senderAvatar;
                        }
                      }
                    });
                    if (latestDriverAvatar != null) {
                      avatarUrl = latestDriverAvatar;
                      debugPrint(
                        '[ClientMessages] 👤 Using fallback avatar from messages for chat $chatId',
                      );
                    }
                  }

                  final normalizedAvatar = UrlUtils.normalizeImageUrl(
                    avatarUrl,
                  );

                  // Parse lastMessageAt
                  DateTime lastMsgAt;
                  final rawLastAt = chatData['lastMessageAt'];
                  if (rawLastAt is int) {
                    lastMsgAt = DateTime.fromMillisecondsSinceEpoch(rawLastAt);
                  } else if (rawLastAt is String) {
                    final parts = rawLastAt.split('::');
                    lastMsgAt =
                        DateTime.tryParse(
                          parts.isNotEmpty ? parts.last : rawLastAt,
                        ) ??
                        DateTime.now();
                  } else if (chatData['lastMessage'] is Map) {
                    final lm = chatData['lastMessage'] as Map;
                    final lmTsRaw = lm['timestamp'] ?? lm['timestap'];
                    if (lmTsRaw is String) {
                      final parts = lmTsRaw.split('::');
                      lastMsgAt =
                          DateTime.tryParse(
                            parts.isNotEmpty ? parts.last : lmTsRaw,
                          ) ??
                          DateTime.now();
                    } else {
                      lastMsgAt = DateTime.now();
                    }
                  } else {
                    lastMsgAt = DateTime.now();
                  }

                  chats.add(
                    DirectChatData(
                      chatId: chatId,
                      driverId: driverIdStr,
                      driverName:
                          chatData['driverName']?.toString() ?? 'Driver',
                      driverAvatar: avatarUrl,
                      lastMessage: lastMessageText.isEmpty
                          ? 'No messages yet'
                          : lastMessageText,
                      lastMessageAt: lastMsgAt,
                      unreadCount: chatData['unreadCount'] is Map
                          ? (chatData['unreadCount'][clientId] as int? ?? 0)
                          : 0,
                    ),
                  );
                } catch (e) {
                  debugPrint('[ClientMessages] ⚠️ Error parsing chat: $e');
                }
              }
            }

            chats.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));

            debugPrint(
              '[ClientMessages] ✅ Loaded ${chats.length} direct chats',
            );
            setState(() {
              _directChats.clear();
              _directChats.addAll(chats);
              _isLoadingDirectChats = false;
            });
          },
          onError: (error) {
            debugPrint('[ClientMessages] ❌ Stream error: $error');
            setState(() => _isLoadingDirectChats = false);
          },
        );
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
          tabs: _buildTabs(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _buildTabViews(colors),
      ),
    );
  }

  /// Build role-aware tabs
  List<Widget> _buildTabs() {
    final tabs = <Widget>[];

    // Direct tab is always shown
    tabs.add(
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
    );

    if (_isStoreMode) {
      // Store role: Show Store Orders (their incoming orders)
      tabs.add(
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.shopping_bag, size: 18.sp),
              SizedBox(width: 8.w),
              Text('store_orders.title'.tr),
            ],
          ),
        ),
      );
    } else if (_isDriverMode) {
      // Driver role: Show Orders (service requests)
      tabs.add(
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.receipt_1, size: 18.sp),
              SizedBox(width: 8.w),
              Text('driver.orders.title'.tr),
            ],
          ),
        ),
      );
    } else {
      // Client role: Show Orders (service requests) and Store Orders
      tabs.add(
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.receipt_1, size: 18.sp),
              SizedBox(width: 8.w),
              Text('client.orders.title'.tr),
            ],
          ),
        ),
      );
      tabs.add(
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.shop, size: 18.sp),
              SizedBox(width: 8.w),
              Text('store_orders.title'.tr),
            ],
          ),
        ),
      );
    }

    return tabs;
  }

  /// Build role-aware tab views
  List<Widget> _buildTabViews(AppColorScheme colors) {
    final views = <Widget>[];

    // Direct chats is always shown
    views.add(_buildDirectChatsTab(colors));

    if (_isStoreMode) {
      // Store role: Show incoming store orders
      views.add(_buildStoreIncomingOrdersTab(colors));
    } else if (_isDriverMode) {
      // Driver role: Show service request orders
      views.add(_buildOrdersTab(colors));
    } else {
      // Client role: Show service orders and store orders
      views.add(_buildOrdersTab(colors));
      views.add(_buildStoreOrdersTab(colors));
    }
    return views;
  }

  Widget _buildDirectChatsTab(AppColorScheme colors) {
    if (_isLoadingDirectChats) {
      return Center(child: CircularProgressIndicator(color: colors.primary));
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
              'messages.no_conversations'.tr,
              style: AppTypography.bodyMedium(
                context,
              ).copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => _listenToDirectChats(),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: _directChats.length,
        itemBuilder: (context, index) {
          final chat = _directChats[index];
          return _DirectChatCard(
            colors: colors,
            chat: chat,
            onTap: () async {
              // Create DriverProfile for navigation
              final userId = int.tryParse(chat.driverId) ?? 0;
              final driver = DriverProfile(
                userId: userId,
                displayName: chat.driverName,
                profilePhotoUrl: chat.driverAvatar,
              );
              Get.toNamed('/direct-chat', arguments: driver);
            },
          );
        },
      ),
    );
  }

  Widget _buildOrdersTab(AppColorScheme colors) {
    return Obx(() {
      final conv = Get.find<ConversationsController>();

      // Merge active requests + history to get all conversations
      final merged = <ServiceRequest>[];

      // Add active request(s)
      if (_requestController.activeRequest.value != null) {
        merged.add(_requestController.activeRequest.value!);
      }
      merged.addAll(_requestController.activeRequests);

      // Add all history requests with assigned driver
      final historyWithDriver = _requestController.requestHistory
          .where((r) => r.driverId != null)
          .toList();
      merged.addAll(historyWithDriver);

      // Deduplicate by request id
      final seen = <int>{};
      final conversations = <ServiceRequest>[];
      for (final r in merged) {
        final id = r.id ?? -1;
        if (!seen.contains(id)) {
          seen.add(id);
          conversations.add(r);
        }
      }

      // Sort by ConversationsController last activity, fallback createdAt
      DateTime _activityFor(ServiceRequest r) {
        final key = (r.id ?? -1).toString();
        return conv.lastActivityByRequestId[key] ?? r.createdAt;
      }

      conversations.sort((a, b) => _activityFor(b).compareTo(_activityFor(a)));

      if (_requestController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: colors.primary),
        );
      }

      if (conversations.isEmpty) {
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
                'Create a request to start chatting',
                style: AppTypography.bodySmall(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          await _requestController.loadActiveRequest();
          await _requestController.loadRequestHistory();
        },
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            final request = conversations[index];
            return _ConversationCard(
              colors: colors,
              request: request,
              chatService: _chatService,
              currentUserId:
                  _authController.currentUser.value?.id.toString() ?? '',
            );
          },
        ),
      );
    });
  }

  Widget _buildStoreOrdersTab(AppColorScheme colors) {
    return Obx(() {
      final controller = Get.find<ClientStoreOrdersController>();

      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: colors.primary),
        );
      }

      final orders = controller.activeOrders;

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
                'No active store orders',
                style: AppTypography.bodyMedium(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
              SizedBox(height: 8.h),
              Text(
                'Browse stores to place an order',
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
            return _StoreOrderCard(
              colors: colors,
              order: order,
              onTap: () {
                Get.toNamed('/client/store-order', arguments: order.id);
              },
            );
          },
        ),
      );
    });
  }

  /// Build Store Incoming Orders tab (for Store role)
  /// Shows orders received by this store
  Widget _buildStoreIncomingOrdersTab(AppColorScheme colors) {
    if (!Get.isRegistered<StoreOrderController>()) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.warning_2,
              size: 64.sp,
              color: colors.textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              'Store not initialized',
              style: AppTypography.bodyMedium(
                context,
              ).copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    return Obx(() {
      final controller = Get.find<StoreOrderController>();

      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: colors.primary),
        );
      }

      // Get active orders for store (pending, confirmed, preparing, ready, in delivery)
      final orders = controller.orders
          .where(
            (o) =>
                o.status == StoreOrderStatus.pending ||
                o.status == StoreOrderStatus.confirmed ||
                o.status == StoreOrderStatus.preparing ||
                o.status == StoreOrderStatus.ready ||
                o.status == StoreOrderStatus.driverAssigned ||
                o.status == StoreOrderStatus.pickedUp ||
                o.status == StoreOrderStatus.inDelivery,
          )
          .toList();

      if (orders.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.shopping_bag,
                size: 64.sp,
                color: colors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                'store_orders.no_orders'.tr.isEmpty
                    ? 'No active orders'
                    : 'store_orders.no_orders'.tr,
                style: AppTypography.bodyMedium(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
              SizedBox(height: 8.h),
              Text(
                'Orders will appear here when customers order',
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
            return _StoreIncomingOrderCard(
              colors: colors,
              order: order,
              clientName: controller.clientNames[order.clientId],
              onTap: () {
                Get.toNamed('/store/orders/detail', arguments: order.id);
              },
            );
          },
        ),
      );
    });
  }
}

class _ConversationCard extends StatefulWidget {
  final AppColorScheme colors;
  final ServiceRequest request;
  final ChatService chatService;
  final String currentUserId;

  const _ConversationCard({
    required this.colors,
    required this.request,
    required this.chatService,
    required this.currentUserId,
  });

  @override
  State<_ConversationCard> createState() => _ConversationCardState();
}

class _ConversationCardState extends State<_ConversationCard> {
  DateTime? _displayTime;
  String? _driverAvatarUrl;

  @override
  void initState() {
    super.initState();
    _loadChatMeta();
    _fetchDriverAvatar();
  }

  Future<void> _loadChatMeta() async {
    try {
      final reqId = widget.request.id?.toString() ?? '';
      if (reqId.isEmpty) return;
      // Directly scan messages to get the latest timestamp
      final latestMsgTime = await widget.chatService.getLatestMessageTime(
        reqId,
      );
      final chosen = latestMsgTime ?? widget.request.createdAt;
      debugPrint(
        '[ConversationCard] ⏱️ requestId=$reqId latestMsgTime=${latestMsgTime?.toIso8601String()} chosen=${chosen.toIso8601String()}',
      );
      setState(() {
        _displayTime = chosen;
      });
    } catch (e) {
      debugPrint('[ConversationCard] ❌ Failed to load chat meta: $e');
      setState(() {
        _displayTime = widget.request.createdAt;
      });
    }
  }

  /// Fetch driver avatar from user profile
  Future<void> _fetchDriverAvatar() async {
    try {
      final driverId = widget.request.driverId;
      if (driverId == null) return;
      debugPrint(
        '[ConversationCard] 🔎 Fetching driver avatar for driverId=$driverId, requestId=${widget.request.id}',
      );
      final client = Get.find<Client>();
      final res = await client.user.getUserById(userId: driverId);
      final rawUrl = res.user?.profilePhotoUrl;
      final normalized = UrlUtils.normalizeImageUrl(rawUrl ?? '');
      debugPrint(
        '[ConversationCard] 🖼️ Avatar fetched: raw="${rawUrl ?? ''}", normalized="${normalized ?? rawUrl ?? ''}"',
      );
      if (mounted) {
        setState(() {
          _driverAvatarUrl = normalized ?? rawUrl;
        });
      }
    } catch (e) {
      debugPrint('[ConversationCard] ❌ Failed to fetch driver avatar: $e');
      // Try fallback: scan messages for driver's sender avatar
      _tryFallbackAvatar();
    }
  }

  /// Fallback: scan messages to find driver's sender avatar
  Future<void> _tryFallbackAvatar() async {
    try {
      final reqId = widget.request.id?.toString() ?? '';
      final driverId = widget.request.driverId.toString();
      if (reqId.isEmpty) return;

      final dbInstance = widget.chatService.database;
      final event = await dbInstance.ref('chats/$reqId/messages').once();

      if (event.snapshot.exists && event.snapshot.value is Map) {
        final msgs = event.snapshot.value as Map<dynamic, dynamic>;
        String? latestDriverAvatar;

        msgs.forEach((key, value) {
          if (value is Map) {
            final senderId = value['senderId']?.toString();
            final senderAvatar = value['senderAvatar']?.toString();
            if (senderId == driverId &&
                senderAvatar != null &&
                senderAvatar.isNotEmpty) {
              latestDriverAvatar = senderAvatar;
              debugPrint(
                '[ConversationCard] 👤 Found fallback avatar from messages for driver $driverId',
              );
            }
          }
        });

        if (latestDriverAvatar != null && mounted) {
          setState(() {
            _driverAvatarUrl = latestDriverAvatar;
          });
        }
      }
    } catch (e) {
      debugPrint('[ConversationCard] ⚠️ Fallback avatar fetch failed: $e');
    }
  }

  String _getOtherPersonName() {
    return widget.request.driverName ?? 'Driver';
  }

  String _getStatusLabel() {
    switch (widget.request.status) {
      case RequestStatus.pending:
        return 'Pending';
      case RequestStatus.driver_proposed:
        return 'Driver Proposed';
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
    final displayTime = _displayTime ?? widget.request.createdAt;
    debugPrint(
      '[ConversationCard] 🎨 Rendering requestId=${widget.request.id} displayTime=${displayTime.toIso8601String()} (_displayTime=${_displayTime?.toIso8601String()}, createdAt=${widget.request.createdAt.toIso8601String()})',
    );

    return InkWell(
      onTap: () {
        // Navigate to chat
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
                      final raw = _driverAvatarUrl;
                      final normalized = UrlUtils.normalizeImageUrl(raw ?? '');
                      debugPrint(
                        '[ConversationCard] 🧱 Building avatar: requestId=${widget.request.id}, raw="${raw ?? ''}", normalized="${normalized ?? raw ?? ''}"',
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
                          _getOtherPersonName(),
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

// Direct chat data model
class DirectChatData {
  final String chatId;
  final String driverId;
  final String driverName;
  final String? driverAvatar;
  final String lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;

  DirectChatData({
    required this.chatId,
    required this.driverId,
    required this.driverName,
    this.driverAvatar,
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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
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
                  child: Builder(
                    builder: (context) {
                      final raw = chat.driverAvatar;
                      final normalized = UrlUtils.normalizeImageUrl(raw ?? '');
                      if (raw != null && raw.isNotEmpty) {
                        return ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: normalized ?? raw,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                              Iconsax.user,
                              color: colors.primary,
                              size: 24.sp,
                            ),
                          ),
                        );
                      }
                      return Icon(
                        Iconsax.user,
                        color: colors.primary,
                        size: 24.sp,
                      );
                    },
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
                          chat.driverName,
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTime(chat.lastMessageAt),
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
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
                            color: colors.textSecondary,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Unread indicator
                      if (chat.unreadCount > 0)
                        Container(
                          margin: EdgeInsets.only(left: 8.w),
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

class _StoreOrderCard extends StatelessWidget {
  final AppColorScheme colors;
  final StoreOrder order;
  final VoidCallback onTap;

  const _StoreOrderCard({
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
        return 'Ready';
      case StoreOrderStatus.driverAssigned:
        return 'Driver Assigned';
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            // Store icon
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Iconsax.shop,
                color: colors.primary,
                size: 24.sp,
              ),
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
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol),
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.primary,
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
                ],
              ),
            ),
            SizedBox(width: 12.w),
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

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dateTime.day}/${dateTime.month}';
  }
}

/// Card widget for incoming store orders (for Store role)
class _StoreIncomingOrderCard extends StatelessWidget {
  final AppColorScheme colors;
  final StoreOrder order;
  final String? clientName;
  final VoidCallback onTap;

  const _StoreIncomingOrderCard({
    required this.colors,
    required this.order,
    required this.onTap,
    this.clientName,
  });

  String _getStatusText(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return 'New Order!';
      case StoreOrderStatus.confirmed:
        return 'Confirmed';
      case StoreOrderStatus.preparing:
        return 'Preparing';
      case StoreOrderStatus.ready:
        return 'Ready for Pickup';
      case StoreOrderStatus.driverAssigned:
        return 'Driver Assigned';
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

  @override
  Widget build(BuildContext context) {
    final isPending = order.status == StoreOrderStatus.pending;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isPending ? colors.primary.withOpacity(0.05) : colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isPending ? colors.primary : colors.border,
            width: isPending ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Customer icon
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: isPending
                    ? colors.primary.withOpacity(0.2)
                    : colors.textSecondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                isPending ? Iconsax.notification_bing : Iconsax.user,
                color: isPending ? colors.primary : colors.textSecondary,
                size: 24.sp,
              ),
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
                          clientName ?? 'Customer #${order.clientId}',
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol),
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    order.orderNumber,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.textSecondary,
                    ),
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
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Chat/Arrow icon
            Column(
              children: [
                Icon(
                  Iconsax.message,
                  color: colors.primary,
                  size: 20.sp,
                ),
                SizedBox(height: 4.h),
                Icon(
                  Icons.chevron_right,
                  color: colors.textSecondary,
                  size: 20.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dateTime.day}/${dateTime.month}';
  }
}
