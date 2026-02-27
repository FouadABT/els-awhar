import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import '../constants/firebase_config.dart';
import '../controllers/auth_controller.dart';

/// Real-time service for monitoring online drivers
/// 
/// Listens to Firebase RTDB presence/drivers path for live status updates
/// Provides reactive list of online drivers with real-time state changes
class LiveDriversService extends GetxService {
  late final DatabaseReference _db;
  final AuthController _authController = Get.find<AuthController>();
  
  // Observable list of online driver IDs from Firebase
  final RxSet<int> onlineDriverIds = <int>{}.obs;
  
  // Stream subscription for presence updates
  StreamSubscription<DatabaseEvent>? _presenceSubscription;
  
  @override
  void onInit() {
    super.onInit();
    
    // Initialize Firebase RTDB with regional config
    final database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL: FirebaseConfig.realtimeDatabaseUrl,
    );
    _db = database.ref();
    
    print('[LiveDriversService] ✅ Initialized with URL: ${FirebaseConfig.realtimeDatabaseUrl}');
  }
  
  @override
  void onClose() {
    stopListening();
    super.onClose();
  }
  
  /// Start listening to driver presence updates
  Future<void> startListening() async {
    if (_presenceSubscription != null) {
      print('[LiveDriversService] Already listening to presence updates');
      return;
    }
    
    try {
      print('[LiveDriversService] 🎧 Starting to listen to presence/drivers/');
      
      // Listen to all driver presence changes
      final presenceRef = _db.child('presence').child('drivers');
      
      _presenceSubscription = presenceRef.onValue.listen((event) {
        if (event.snapshot.value == null) {
          print('[LiveDriversService] ❌ No data at presence/drivers path');
          onlineDriverIds.clear();
          return;
        }
        
        print('[LiveDriversService] 📡 Raw Firebase data: ${event.snapshot.value}');
        
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        final Set<int> newOnlineIds = {};
        
        print('[LiveDriversService] 🔍 Checking ${data.length} driver(s) in Firebase...');
        
        data.forEach((key, value) {
          try {
            final driverId = int.parse(key.toString());
            final driverData = value as Map<dynamic, dynamic>;
            final state = driverData['state'] as String?;
            
            print('[LiveDriversService]   Driver $driverId: state=$state');
            
            // Trust Firebase state directly - onDisconnect handles app closures
            if (state == 'online') {
              newOnlineIds.add(driverId);
              print('[LiveDriversService]     ✅ ONLINE - Added to list');
            } else {
              print('[LiveDriversService]     ❌ State is offline');
            }
          } catch (e) {
            print('[LiveDriversService] ❌ Error parsing driver $key: $e');
          }
        });
        
        // Update observable set
        onlineDriverIds.value = newOnlineIds;
        
        print('[LiveDriversService] 📊 Updated: ${newOnlineIds.length} drivers online');
        if (newOnlineIds.isNotEmpty) {
          print('[LiveDriversService] 👥 Online driver IDs: $newOnlineIds');
        }
      }, onError: (error) {
        print('[LiveDriversService] ❌ Error listening to presence: $error');
      });
      
    } catch (e) {
      print('[LiveDriversService] ❌ Failed to start listening: $e');
    }
  }
  
  /// Stop listening to driver presence updates
  void stopListening() {
    _presenceSubscription?.cancel();
    _presenceSubscription = null;
    print('[LiveDriversService] 🛑 Stopped listening to presence updates');
  }
  
  /// Check if a specific driver is currently online
  bool isDriverOnline(int driverId) {
    return onlineDriverIds.contains(driverId);
  }
  
  /// Get count of online drivers
  int get onlineCount => onlineDriverIds.length;
}
