import 'dart:async';
import 'dart:io' show Platform;
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:awhar_client/awhar_client.dart' as proto;
import '../controllers/auth_controller.dart';
import '../constants/firebase_config.dart';

/// Professional Realtime Presence Service
/// 
/// Architecture:
/// - Driver goes online via toggle → 30 minute session starts
/// - Heartbeat every 2 minutes keeps session fresh
/// - Firebase presence stores realtime state  
/// - Backend DB stores authoritative state (survives app restart)
/// - After 30 min inactivity: send notification asking if still online
/// - If no response in 5 min: auto-offline
/// 
/// Paths:
/// - presence/users/{userId} => { state, lastSeen, platform, sessionStart }
/// - presence/drivers/{userId} => mirrored for driver screens
class PresenceService extends GetxService {
  late final DatabaseReference _db;
  final AuthController _auth = Get.find<AuthController>();

  final RxBool isOnline = false.obs;
  Timer? _heartbeatTimer;

  // Professional timing constants
  static const Duration heartbeatInterval = Duration(minutes: 2);
  static const Duration onlineGracePeriod = Duration(minutes: 2);  // For UI display
  static const Duration sessionDuration = Duration(minutes: 30);   // Before asking
  
  @override
  void onInit() {
    super.onInit();
    // Initialize with Firebase config
    final database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL: FirebaseConfig.realtimeDatabaseUrl,
    );
    _db = database.ref();
    print('[PresenceService] ✅ Initialized with URL: ${FirebaseConfig.realtimeDatabaseUrl}');
  }

  @override
  void onClose() {
    _heartbeatTimer?.cancel();
    super.onClose();
  }

  /// Set presence for the current user (called by DriverStatusController)
  Future<bool> setOnlineForCurrentUser(bool online) async {
    print('[PresenceService] 🔄 setOnlineForCurrentUser($online)');
    
    final appUser = _auth.currentUser.value;
    if (appUser == null || appUser.id == null) {
      print('[PresenceService] ❌ No app user, skipping');
      return false;
    }

    final firebaseUser = fb_auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      print('[PresenceService] ❌ No Firebase user, skipping');
      return false;
    }
    
    print('[PresenceService] 📝 userId=${appUser.id}, firebaseUid=${firebaseUser.uid}');

    final userId = appUser.id!;
    final isDriver = appUser.roles.contains(proto.UserRole.driver);
    final now = DateTime.now().millisecondsSinceEpoch;
    
    final payload = {
      'state': online ? 'online' : 'offline',
      'lastSeen': now,
      'platform': _platformString(),
      if (online) 'sessionStart': now,
    };

    try {
      // Write to users presence with timeout to prevent blocking
      final userRef = _db.child('presence').child('users').child('$userId');
      
      try {
        await userRef.set(payload).timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            print('[PresenceService] ⚠️ Timeout writing to Firebase - continuing anyway');
            return;
          },
        );
        print('[PresenceService] ✅ Written to users/$userId');
      } catch (e) {
        print('[PresenceService] ⚠️ Error writing to users/$userId: $e');
        // Continue - don't fail the whole operation
      }

      if (online) {
        // Set onDisconnect handler (fire and forget)
        userRef.onDisconnect().set({
          'state': 'offline',
          'lastSeen': ServerValue.timestamp,
          'platform': _platformString(),
        }).catchError((e) => print('[PresenceService] onDisconnect error: $e'));
      } else {
        // Cancel onDisconnect when going offline explicitly
        userRef.onDisconnect().cancel().catchError((e) {});
      }

      // Mirror for drivers (also with timeout)
      if (isDriver) {
        final driverRef = _db.child('presence').child('drivers').child('$userId');
        try {
          await driverRef.set(payload).timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              print('[PresenceService] ⚠️ Timeout writing driver presence');
              return;
            },
          );
          print('[PresenceService] ✅ Written to drivers/$userId');
        } catch (e) {
          print('[PresenceService] ⚠️ Error writing to drivers/$userId: $e');
        }
        
        if (online) {
          driverRef.onDisconnect().set({
            'state': 'offline',
            'lastSeen': ServerValue.timestamp,
            'platform': _platformString(),
          }).catchError((e) {});
        } else {
          driverRef.onDisconnect().cancel().catchError((e) {});
        }
      }

      isOnline.value = online;
      _toggleHeartbeat(online);
      
      print('[PresenceService] ✅ Presence ${online ? "ONLINE" : "OFFLINE"} for userId=$userId');
      return true;
    } catch (e) {
      print('[PresenceService] ❌ Error: $e');
      return false;
    }
  }

  /// Stream whether a user is online (for UI display)
  Stream<bool> watchUserOnline(int userId) {
    return _db.child('presence').child('users').child('$userId').onValue.map((event) {
      if (!event.snapshot.exists) return false;
      final raw = event.snapshot.value;
      if (raw is! Map) return false;

      final state = raw['state'] as String? ?? 'offline';
      final lastSeenMs = (raw['lastSeen'] as num?)?.toInt();
      if (lastSeenMs == null) return false;
      
      final lastSeen = DateTime.fromMillisecondsSinceEpoch(lastSeenMs);
      final fresh = DateTime.now().difference(lastSeen) <= onlineGracePeriod;

      return state == 'online' && fresh;
    });
  }

  /// Send heartbeat to keep presence fresh
  Future<void> sendHeartbeat() async {
    final appUser = _auth.currentUser.value;
    if (appUser?.id == null) return;

    final firebaseUser = fb_auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;

    final userId = appUser!.id!;
    
    try {
      final update = {'lastSeen': ServerValue.timestamp};
      
      await _db.child('presence').child('users').child('$userId').update(update);
      
      if (appUser.roles.contains(proto.UserRole.driver)) {
        await _db.child('presence').child('drivers').child('$userId').update(update);
      }
      
      print('[PresenceService] 💓 Heartbeat sent');
    } catch (e) {
      print('[PresenceService] ❌ Heartbeat error: $e');
    }
  }

  void _toggleHeartbeat(bool enable) {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    
    if (!enable) return;

    // Send immediate heartbeat
    sendHeartbeat();
    
    // Then periodic
    _heartbeatTimer = Timer.periodic(heartbeatInterval, (_) => sendHeartbeat());
  }

  String _platformString() {
    try {
      if (Platform.isAndroid) return 'android';
      if (Platform.isIOS) return 'ios';
      if (Platform.isWindows) return 'windows';
      if (Platform.isMacOS) return 'macos';
      if (Platform.isLinux) return 'linux';
    } catch (_) {}
    return 'web';
  }
}
