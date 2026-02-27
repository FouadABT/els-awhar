# 🦊 Awhar Butler - Flutter Mobile App

> **Beautiful, native mobile experience for iOS and Android**

This is the **Flutter 3.32+ mobile application** that provides the user interface for clients, drivers, and stores in the Awhar Butler platform.

---

## 📱 What This App Does

**Awhar Flutter** is the face of the platform. It provides:

✅ **Three User Roles** — Client, Driver, Store owner  
✅ **Auto-Discovery** — Push notifications for nearby jobs  
✅ **Live Tracking** — Real-time driver location on Google Maps  
✅ **Smart Pricing** — Transparent, auto-calculated prices  
✅ **Real-Time Chat** — Firebase Realtime Database messaging  
✅ **Multi-Language** — Arabic (RTL), French, English, Spanish  
✅ **Beautiful UI** — Material Design 3 with custom theming  
✅ **GetX Architecture** — Reactive state management  

---

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK**: 3.32 or higher
- **Dart SDK**: 3.6 or higher
- **Android Studio** / **Xcode** (for iOS)
- **Serverpod Backend**: Running on `localhost:8080` or custom URL
- **Firebase Project**: Configured for authentication

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Configure Server URL

**Edit**: `lib/config/app_config.dart`

```dart
class AppConfig {
  static const String serverUrl = 'http://localhost:8080/';
  
  // For physical device testing:
  // static const String serverUrl = 'http://192.168.X.X:8080/';
}
```

### 3. Firebase Setup

**Already configured** in `firebase_options.dart` and platform-specific files:
- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`

**To reconfigure** (if needed):
```bash
flutterfire configure
```

### 4. Run the App

```bash
# Run on connected device/emulator
flutter run

# Run with custom server URL
flutter run --dart-define=SERVER_URL=http://192.168.1.100:8080/

# Run on specific device
flutter run -d <device-id>
```

---

## 🎨 User Roles

### 1. Client (👤 Service Requester)

**Screens**:
- `explore_screen.dart` — Browse services and stores
- `create_request_screen.dart` — Create service requests
- `client_active_request_screen.dart` — Track active request
- `client_stores_screen.dart` — Browse stores
- `store_detail_screen.dart` — View store products
- `cart_screen.dart` — Shopping cart
- `checkout_screen.dart` — Order checkout

**Features**:
- Browse driver services
- Create ride/delivery requests
- Order from stores
- Live track drivers on map
- Chat with drivers
- Rate and review

### 2. Driver (🚗 Service Provider)

**Screens**:
- `driver_dashboard_screen.dart` — Main dashboard
- `available_requests_screen.dart` — Browse job opportunities
- `driver_active_request_screen.dart` — Active job tracking
- `driver_services_screen.dart` — Manage services offered
- `add_service_screen.dart` — Add new service
- `driver_earnings_screen.dart` — Earnings dashboard
- `driver_location_screen.dart` — Location broadcasting

**Features**:
- Receive job notifications
- Accept/reject requests
- View auto-calculated earnings
- Update live location
- Chat with clients
- Manage availability (online/offline)
- View earnings statistics

### 3. Store (🏪 Business Owner)

**Screens**:
- `store_dashboard_screen.dart` — Store overview
- `store_orders_screen.dart` — Order management
- `store_order_detail_screen.dart` — Order details
- `store_products_screen.dart` — Product catalog
- `add_product_screen.dart` — Add new product
- `find_driver_screen.dart` — Dispatch delivery
- `store_analytics_screen.dart` — Business metrics

**Features**:
- Manage product catalog
- Accept/reject orders
- Find and assign drivers
- Track deliveries
- Chat with customers and drivers
- View earnings and analytics

---

## 📦 Key Dependencies

### Serverpod Client

```yaml
serverpod_flutter: ^3.1.1  # Auto-generated client for backend API
```

**Usage**:
```dart
final client = Client('http://localhost:8080/');
final user = await client.user.getUser(userId);
```

### State Management - GetX

```yaml
get: ^4.6.6  # Reactive state management
```

**Controller Example**:
```dart
class RequestController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<ServiceRequest?> activeRequest = Rx<ServiceRequest?>(null);
  
  Future<void> createRequest(ServiceRequest request) async {
    isLoading.value = true;
    try {
      final result = await Get.find<Client>().request.createRequest(request);
      activeRequest.value = result;
    } finally {
      isLoading.value = false;
    }
  }
}
```

### Firebase Services

```yaml
firebase_core: ^3.8.1
firebase_auth: ^5.3.3              # Google, Email, Phone auth
firebase_messaging: ^15.1.5        # Push notifications
firebase_database: ^11.1.7         # Real-time chat
firebase_storage: ^12.3.8          # Media uploads
```

### Google Maps

```yaml
google_maps_flutter: ^2.10.0       # Maps and location
geolocator: ^13.0.2                # GPS positioning
geocoding: ^3.0.0                  # Address ↔ Coordinates
```

### UI & Media

```yaml
cached_network_image: ^3.4.1       # Image caching
image_picker: ^1.1.2               # Camera/gallery
image_cropper: ^8.0.3              # Image editing
flutter_image_compress: ^2.3.0     # Image optimization
flutter_screenutil: ^5.9.3         # Responsive design
```

### Storage & Local Data

```yaml
get_storage: ^2.1.1                # Local key-value storage
shared_preferences: ^2.3.4         # Persistent settings
```

---

## 🌍 Multi-Language Support

### Available Languages

| Language | Code | Direction | Status |
|----------|------|-----------|--------|
| Arabic | `ar` | RTL | ✅ |
| English | `en` | LTR | ✅ |
| French | `fr` | LTR | ✅ |
| Spanish | `es` | LTR | ✅ |

### Translation Files

Located in `assets/translations/`:

**Example** (`en.json`):
```json
{
  "auth": {
    "login": "Login",
    "register": "Register",
    "email": "Email",
    "password": "Password"
  },
  "home": {
    "welcome": "Welcome to Awhar",
    "find_service": "Find a Service"
  },
  "profile": {
    "title": "Profile",
    "edit": "Edit Profile",
    "sign_out": "Sign Out"
  }
}
```

### Usage in Code

```dart
Text('auth.login'.tr)  // Returns "Login"
Text('home.welcome'.tr)  // Returns "Welcome to Awhar"
```

### Language Switching

```dart
// In settings or language selector
Get.updateLocale(Locale('ar', 'MA'));  // Arabic (Morocco)
Get.updateLocale(Locale('en', 'US'));  // English
Get.updateLocale(Locale('fr', 'FR'));  // French
```

---

## 🎨 Theming

### App Colors

**Location**: `lib/core/theme/app_colors.dart`

```dart
class AppColors {
  static const light = LightColors(
    primary: Color(0xFF2196F3),
    secondary: Color(0xFF03A9F4),
    background: Color(0xFFFAFAFA),
    surface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF212121),
    textSecondary: Color(0xFF757575),
  );
  
  static const dark = DarkColors(
    primary: Color(0xFF90CAF9),
    secondary: Color(0xFF81D4FA),
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB0B0B0),
  );
}
```

### Usage in Screens

```dart
Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final colors = isDark ? AppColors.dark : AppColors.light;
  
  return Scaffold(
    backgroundColor: colors.background,
    body: Text(
      'Hello',
      style: TextStyle(color: colors.textPrimary),
    ),
  );
}
```

### Responsive Design

Using **flutter_screenutil**:

```dart
// Height
SizedBox(height: 16.h)

// Width
SizedBox(width: 24.w)

// Font size
Text('Hello', style: TextStyle(fontSize: 14.sp))

// Radius
BorderRadius.circular(12.r)
```

---

## 🔔 Push Notifications

### Firebase Cloud Messaging Setup

**Service**: `lib/core/services/notification_service.dart`

**Initialization**:
```dart
final messaging = FirebaseMessaging.instance;

// Request permission
await messaging.requestPermission(
  alert: true,
  badge: true,
  sound: true,
);

// Get FCM token
final token = await messaging.getToken();
await client.notification.registerToken(userId, token);

// Handle notifications
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  _showLocalNotification(message);
});
```

### Notification Types

**For Drivers**:
- 🔔 New job request nearby
- 💰 Job accepted by client
- 📍 Client location updated

**For Clients**:
- 🚗 Driver accepted your request
- 📍 Driver is on the way
- ✅ Job completed

**For Stores**:
- 📦 New order received
- 🚗 Driver assigned
- ✅ Delivery completed

---

## 📍 Location Services

### Real-Time Location Tracking

**Service**: `lib/core/services/location_service.dart`

**Broadcasting** (Drivers):
```dart
// Update location every 10 seconds
Timer.periodic(Duration(seconds: 10), (timer) async {
  final position = await Geolocator.getCurrentPosition();
  
  await client.location.updateLocation(
    driverId,
    Location(
      latitude: position.latitude,
      longitude: position.longitude,
    ),
  );
});
```

**Tracking** (Clients):
```dart
// Poll for driver location
Timer.periodic(Duration(seconds: 10), (timer) async {
  final location = await client.location.getDriverLocation(driverId);
  
  // Update marker on map
  _updateMapMarker(location);
});
```

---

## 💬 Real-Time Chat

### Firebase Realtime Database

**Service**: `lib/core/services/chat_service.dart`

**Send Message**:
```dart
final chatRef = FirebaseDatabase.instance
    .ref('chats/$chatId/messages')
    .push();

await chatRef.set({
  'senderId': currentUserId,
  'text': message,
  'timestamp': ServerValue.timestamp,
  'type': 'text',
});
```

**Listen to Messages**:
```dart
final messagesStream = FirebaseDatabase.instance
    .ref('chats/$chatId/messages')
    .orderByChild('timestamp')
    .onValue;

messagesStream.listen((event) {
  final messages = _parseMessages(event.snapshot.value);
  chatController.messages.value = messages;
});
```

### Message Types

- 📝 Text messages
- 🖼️ Images
- 🎤 Voice notes (audio)
- 📍 Location sharing

---

## 🎯 Demo Accounts

Test the app with pre-configured users:

| Email | Password | Role | Features to Test |
|-------|----------|------|------------------|
| `sarah.client@awhar.demo` | `Demo123` | Client | Browse services, create requests |
| `mohamed.driver@awhar.demo` | `Demo123` | Driver | Accept jobs, track earnings |
| `pizza.express@awhar.demo` | `Demo123` | Store | Manage orders, dispatch drivers |

**Full details**: See [/docs/DEMO_ACCOUNTS.md](../docs/DEMO_ACCOUNTS.md)

---

## 🚀 Build & Release

### Android APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release
```

**Output**: `build/app/outputs/flutter-apk/`

### iOS

```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release
```

**Open in Xcode** for signing and distribution.

---

## 📚 Resources

**Flutter Documentation**: https://flutter.dev/docs

**GetX State Management**: https://github.com/jonataslaw/getx

**Firebase Flutter**: https://firebase.flutter.dev

**Google Maps Flutter**: https://pub.dev/packages/google_maps_flutter

---

<div align="center">

**🦊 Awhar Butler Mobile App**

*Built with Flutter 3.32+ and GetX*

[Main Repository](https://github.com/FouadABT/awhar-butler) • [Backend](../awhar_server/)

</div>
