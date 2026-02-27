# Awhar Backend - AI Coding Agent Instructions

## Project Overview

**Awhar** is a service marketplace platform connecting clients with drivers/service providers in Morocco. The project uses a **Serverpod** backend with a **Flutter** mobile app, integrated with **Firebase** for authentication and real-time features.

### Tech Stack
- **Backend**: Serverpod 3.1.1 (Dart)
- **Frontend**: Flutter 3.32+ with GetX state management
- **Database**: PostgreSQL (via Serverpod ORM)
- **Cache**: Redis (optional, disabled in development)
- **Auth**: Firebase Auth (Google, Email, Phone) + Custom JWT tokens
- **Storage**: Local file storage (development) / Firebase Storage (production)
- **Languages**: Multi-language support (English, Arabic, French, Spanish)

---

## Project Structure

```
awhar_backend/
├── awhar_server/     # Serverpod backend (Dart)
│   ├── bin/main.dart         # Server entry point
│   ├── config/               # Environment configs (development.yaml, production.yaml)
│   ├── lib/src/
│   │   ├── endpoints/        # API endpoints
│   │   ├── auth/             # Auth endpoints (email_idp, jwt_refresh)
│   │   ├── generated/        # Auto-generated protocol code (DO NOT EDIT)
│   │   ├── protocol/         # Protocol YAML definitions
│   │   └── web/              # Web routes
│   └── migrations/           # Database migrations
│
├── awhar_client/     # Generated client library (DO NOT EDIT)
│   └── lib/src/protocol/     # Generated client protocol
│
└── awhar_flutter/    # Flutter mobile app
    ├── lib/
    │   ├── main.dart         # App entry point
    │   ├── app/              # App modules (routes, bindings)
    │   ├── core/             # Core functionality
    │   │   ├── controllers/  # GetX controllers
    │   │   ├── services/     # Business logic services
    │   │   ├── theme/        # App theming (AppColors, AppTypography)
    │   │   ├── localization/ # Translation system
    │   │   ├── constants/    # App constants
    │   │   └── utils/        # Utility functions
    │   ├── screens/          # Standalone screens
    │   └── shared/           # Shared widgets
    └── assets/
        └── translations/     # JSON translation files (en.json, ar.json, fr.json, es.json)
```

---

## Critical Commands

### Starting the Server (IMPORTANT!)

**Always run from the `awhar_server` directory:**

```powershell
# 1. Start Docker (PostgreSQL + Redis)
cd c:\Users\fabat\Desktop\Awhar\modernapp\v1\awhar_backend\awhar_server
docker-compose up -d

# 2. Run the server
dart run bin/main.dart

# OR with migrations
dart run bin/main.dart --apply-migrations
```

> ⚠️ **NEVER** run `dart run` from the parent `awhar_backend` folder. The server needs access to `config/` files which are relative to `awhar_server`.

### Regenerating Protocol Code

After modifying any protocol YAML files in `lib/src/protocol/`:

```powershell
cd awhar_server
dart run serverpod_cli generate
```

This regenerates:
- `awhar_server/lib/src/generated/` - Server protocol classes
- `awhar_client/lib/src/protocol/` - Client protocol classes

### Running Flutter App

```powershell
cd awhar_flutter
flutter run
```

For physical device, set server URL:
```powershell
flutter run --dart-define=SERVER_URL=http://192.168.X.X:8080/
```

---

## Architecture Patterns

### GetX Controllers

All controllers extend `GetxController` and use reactive variables:

```dart
class ExampleController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    // Initialize
  }
}
```

**Controller Registration:**
- Permanent controllers in `InitialBinding` (AuthController, ThemeController, LocaleController)
- Lazy controllers registered with `Get.lazyPut()` or `Get.put()` when needed

### Screen Structure

Screens follow this pattern:

```dart
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.find<ExampleController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('screen.title'.tr),
      ),
      body: Obx(() => /* reactive UI */),
    );
  }
}
```

### Serverpod Endpoints

Endpoints in `lib/src/endpoints/`:

```dart
class UserEndpoint extends Endpoint {
  Future<User?> getUser(Session session, int userId) async {
    return await User.db.findById(session, userId);
  }

  Future<User> updateUser(Session session, User user) async {
    return await User.db.updateRow(session, user);
  }
}
```

**Call from Flutter:**
```dart
final client = Get.find<Client>();
final user = await client.user.getUser(userId);
```

---

## Translation System

### Format

Translations use nested JSON with dot notation keys:

```json
// assets/translations/en.json
{
  "profile": {
    "title": "Profile",
    "sign_out": "Sign Out",
    "edit_profile": "Edit Profile"
  }
}
```

### Usage

```dart
Text('profile.title'.tr)  // Returns "Profile"
Text('profile.sign_out'.tr)  // Returns "Sign Out"
```

### Key Naming Convention

- Use lowercase with underscores
- Group by feature: `auth.xxx`, `profile.xxx`, `home.xxx`, `settings.xxx`
- Common actions: `common.save`, `common.cancel`, `common.ok`
- Errors: `errors.network_error`, `errors.invalid_email`

---

## User Roles

The app supports two user roles:

```dart
enum UserRole {
  client,  // Service requester
  driver,  // Service provider/driver
}
```

Access current role:
```dart
final user = authController.currentUser.value;
final isDriver = user?.roles.contains(UserRole.driver) ?? false;
```

---

## Theming

### Colors

Use `AppColors` for consistent theming:

```dart
final isDark = Theme.of(context).brightness == Brightness.dark;
final colors = isDark ? AppColors.dark : AppColors.light;

Container(
  color: colors.background,
  child: Text('Hello', style: TextStyle(color: colors.textPrimary)),
)
```

### Typography

Use `AppTypography` for text styles:

```dart
Text('Title', style: AppTypography.heading1(colors.textPrimary))
Text('Body', style: AppTypography.body(colors.textSecondary))
```

### Responsive Design

Use `flutter_screenutil` for responsive sizing:

```dart
SizedBox(height: 16.h)  // Height
SizedBox(width: 24.w)   // Width
Text('Hello', style: TextStyle(fontSize: 14.sp))  // Font size
BorderRadius.circular(12.r)  // Radius
```

---

## File Storage

### Development Configuration

In `config/development.yaml`:

```yaml
maxRequestSize: 10485760  # 10MB for image uploads

storage:
  public:
    type: file
    path: ./storage/public
    publicPath: /storage/public
```

### Upload Pattern

```dart
// Server endpoint
Future<String?> uploadProfilePhoto(Session session, int userId, ByteData imageData) async {
  final fileName = 'profile_$userId.jpg';
  final storageUrl = await session.storage.storeFile(
    storageId: 'public',
    path: 'profiles/$fileName',
    byteData: imageData,
  );
  return storageUrl;
}
```

---

## Firebase Integration

### Authentication Flow

1. User signs in with Firebase (Google/Email/Phone)
2. Get Firebase ID token
3. Exchange for Serverpod JWT via `AuthEndpoint`
4. Store JWT for API calls

```dart
// Get Firebase token
final firebaseToken = await FirebaseAuth.instance.currentUser?.getIdToken();

// Exchange for Serverpod auth
final result = await client.auth.authenticateWithFirebase(firebaseToken!);
```

### Firebase Project

- Project ID: `awhar-5afc5`
- Phone Auth: Morocco (+212) support enabled
- Configuration in `firebase_options.dart`

---

## Common Gotchas

### 1. Server Won't Start

**Problem**: `Could not find file` or `Null check operator used on a null value`

**Solution**: Run from `awhar_server` directory, not parent folder.

### 2. Protocol Changes Not Reflected

**Problem**: Client can't find new endpoint methods

**Solution**: Run `dart run serverpod_cli generate` from server directory.

### 3. Image Upload Crashes

**Problem**: App crashes when uploading large images

**Solution**: 
- Ensure `maxRequestSize` is set in config (10MB recommended)
- Compress images before upload (max 5MB, quality 70%)
- Check storage configuration exists

### 4. Translation Key Not Found

**Problem**: Shows key like `profile.title` instead of translated text

**Solution**:
- Ensure key exists in all translation JSON files
- Check translations are loaded before app starts
- Verify using dot notation: `profile.title`, not `profile_title`

### 5. GetX Controller Not Found

**Problem**: `Get.find<Controller>()` throws error

**Solution**:
- Check controller is registered in bindings
- For lazy registration: `Get.lazyPut(() => Controller())`
- For immediate: `Get.put(Controller())`

---

## Testing

### Integration Tests

Located in `awhar_server/test/integration/`:

```dart
withServerpod('Given User endpoint', (sessionBuilder, endpoints) {
  test('when getting user then returns user data', () async {
    final user = await endpoints.user.getUser(sessionBuilder, 1);
    expect(user, isNotNull);
  });
});
```

Run tests:
```powershell
cd awhar_server
dart test
```

---

## Code Style

### Dart/Flutter

- Use `package:lints/recommended.yaml` analysis options
- Enable `unawaited_futures` and `avoid_print` lints
- Format code with `dart format .`

### Naming Conventions

- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/functions: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE` or `camelCase`
- Translation keys: `category.key_name`

### Import Order

1. Dart SDK
2. Flutter SDK
3. External packages
4. Local packages (`awhar_client`)
5. Relative imports

---

## Environment Configuration

### Development

- Server: `localhost:8080`
- Database: PostgreSQL on `localhost:8090`
- Storage: Local filesystem `./storage/public`

### Production

- Configure in `config/production.yaml`
- Use environment variables for secrets
- Enable Redis for caching
- Use Firebase Storage for files

---

## Dependencies

### Flutter Key Packages

| Package | Purpose |
|---------|---------|
| `get` | State management, routing, DI |
| `get_storage` | Local key-value storage |
| `serverpod_flutter` | Serverpod client |
| `firebase_auth` | Authentication |
| `google_sign_in` | Google OAuth |
| `flutter_screenutil` | Responsive design |
| `image_picker` | Camera/gallery access |
| `image_cropper` | Image cropping |
| `flutter_image_compress` | Image compression |
| `cached_network_image` | Image caching |

### Server Key Packages

| Package | Purpose |
|---------|---------|
| `serverpod` | Backend framework |
| `serverpod_auth_idp_server` | Auth integration |
| `http` | HTTP client |

---

## Quick Reference

### Create New Endpoint

1. Create file in `awhar_server/lib/src/endpoints/`
2. Extend `Endpoint` class
3. Add methods with `Session` as first parameter
4. Run `dart run serverpod_cli generate`

### Create New Screen

1. Create file in `awhar_flutter/lib/screens/`
2. Add route in `app/routes/app_routes.dart`
3. Register any controllers in bindings

### Add Translation

1. Add keys to all JSON files in `assets/translations/`
2. Use with `'key.name'.tr`

### Add New Protocol Model

1. Create YAML in `awhar_server/lib/src/protocol/`
2. Run `dart run serverpod_cli generate`
3. Create migration if database table needed

---

## Contact & Resources

- [Serverpod Documentation](https://docs.serverpod.dev)
- [GetX Documentation](https://github.com/jonataslaw/getx)
- [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil)
