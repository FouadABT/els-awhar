# 🦊 Awhar Butler - Admin Dashboard

> **Web-based admin panel for platform management**

This is the **Flutter Web admin dashboard** for managing users, monitoring activity, and configuring the Awhar Butler platform.

---

## 📊 What This Dashboard Does

**Awhar Admin** provides centralized platform management:

✅ **User Management** — View, edit, block users  
✅ **Driver Verification** — Approve driver applications  
✅ **Order Monitoring** — Track all platform orders  
✅ **Transaction Overview** — Payment and earnings tracking  
✅ **Store Management** — Approve and manage stores  
✅ **Reports & Analytics** — Platform statistics  
✅ **Promo Code Management** — Create and manage discounts  
✅ **Dispute Resolution** — Handle user complaints  

---

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK**: 3.32 or higher
- **Dart SDK**: 3.6 or higher
- **Chrome** or **Edge** browser
- **Serverpod Backend**: Running with admin endpoints

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Configure API URL

**Edit**: `lib/core/services/api_service.dart`

```dart
class ApiService {
  static const String baseUrl = 'http://localhost:8080';
  
  // For production:
  // static const String baseUrl = 'https://api.awhar.io';
}
```

### 3. Run the Dashboard

```bash
# Run in Chrome
flutter run -d chrome

# Run in Edge
flutter run -d edge

# Run with web-server mode
flutter run -d web-server --web-port=8000
```

**Access**: `http://localhost:8000`

### 4. Login

**Admin Credentials**:
- Email: `admin@awhar.io`
- Password: Set in Serverpod backend

---

## 📊 Dashboard Features

### 1. Dashboard Home

**Statistics Cards**:
- Total Users
- Active Drivers
- Total Orders
- Platform Revenue

**Recent Activity**:
- New user registrations
- Recent orders
- Driver applications
- Store registrations

**Charts**:
- Daily order volume
- Revenue trends
- User growth
- Driver activity

### 2. User Management

**Features**:
- View all users (clients, drivers, stores)
- Search and filter users
- View user details
- Block/unblock users
- View user transaction history
- Reset passwords

**Table Columns**:
- User ID
- Name
- Email
- Phone
- Role (Client/Driver/Store)
- Status (Active/Blocked)
- Registration Date
- Actions

### 3. Driver Management

**Features**:
- View all driver applications
- Approve/reject drivers
- View driver documents
- Check vehicle information
- Monitor driver ratings
- View driver earnings

**Driver Verification**:
- License verification
- Vehicle registration check
- Insurance validation
- Background check status

### 4. Order Management

**Features**:
- View all orders (service requests + store orders)
- Filter by status (pending, active, completed, cancelled)
- Search by order ID or user
- View order details
- Monitor delivery progress
- Handle disputes

**Order Details**:
- Order ID and timestamp
- Client information
- Driver/store information
- Service/product details
- Price breakdown
- Status history
- Location tracking

### 5. Store Management

**Features**:
- View all registered stores
- Approve/reject store applications
- Manage store categories
- Monitor store orders
- View store earnings
- Handle store reports

**Store Verification**:
- Business license check
- Address verification
- Menu/product review
- Operating hours validation

### 6. Transaction Management

**Features**:
- View all platform transactions
- Filter by type (payment, refund, withdrawal)
- Search by transaction ID
- Export reports (CSV, Excel)
- Monitor payment gateways
- Handle refund requests

**Transaction Details**:
- Transaction ID
- User information
- Amount and currency
- Payment method
- Status
- Timestamp
- Related order

### 7. Promo Code Management

**Features**:
- Create new promo codes
- Edit existing promos
- Set discount amounts/percentages
- Define validity periods
- Limit usage (per user, total uses)
- Track promo usage

**Promo Configuration**:
```dart
Promo(
  code: 'WELCOME50',
  discountType: DiscountType.percentage,
  discountValue: 50.0,
  maxDiscount: 100.0,
  validFrom: DateTime(2026, 1, 1),
  validUntil: DateTime(2026, 12, 31),
  maxUsesPerUser: 1,
  totalMaxUses: 1000,
  minOrderAmount: 50.0,
)
```

### 8. Reports & Analytics

**Reports Available**:
- User growth report
- Order volume report
- Revenue report
- Driver performance report
- Store performance report
- Geographic distribution
- Peak hours analysis

**Export Formats**:
- PDF
- CSV
- Excel
- JSON

---

## 🎨 UI Components

### Stat Cards

**Component**: `lib/widgets/stat_card.dart`

```dart
StatCard(
  title: 'Total Users',
  value: '1,234',
  icon: Icons.people,
  color: Colors.blue,
  trend: '+12%',
)
```

### Data Tables

**Component**: `lib/widgets/data_table_card.dart`

```dart
DataTableCard(
  title: 'Recent Orders',
  columns: ['Order ID', 'Client', 'Driver', 'Amount', 'Status'],
  rows: orders,
  onRowTap: (order) => _showOrderDetails(order),
)
```

### Sidebar Navigation

**Component**: `lib/widgets/admin_sidebar.dart`

**Menu Items**:
- 📊 Dashboard
- 👥 Users
- 🚗 Drivers
- 📦 Orders
- 🏪 Stores
- 💳 Transactions
- 🎟️ Promos
- 📊 Reports
- 👨‍💼 Admins
- ⚙️ Settings

---

## 🔐 Admin Authentication

### Login Flow

```dart
class AuthController extends GetxController {
  Future<void> login(String email, String password) async {
    try {
      final response = await client.admin.login(email, password);
      
      if (response.isAdmin) {
        _saveToken(response.token);
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar('Error', 'Unauthorized access');
      }
    } catch (e) {
      Get.snackbar('Error', 'Invalid credentials');
    }
  }
}
```

### Admin Permissions

**Roles**:
- **Super Admin**: Full platform access
- **Operations Admin**: User and order management
- **Finance Admin**: Transaction and payment access
- **Support Admin**: Reports and dispute resolution

---

## 🚀 Build for Production

### Build Web Release

```bash
flutter build web --release
```

**Output**: `build/web/`

### Deploy to Server

```bash
# Copy to web server
cp -r build/web/* /var/www/admin.awhar.io/

# Or deploy to Firebase Hosting
firebase deploy --only hosting:admin
```

---

## 📚 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  get: ^4.6.6
  
  # Serverpod Client
  awhar_client:
    path: ../awhar_client
  
  # UI
  flutter_screenutil: ^5.9.3
  
  # Data
  intl: ^0.19.0
  
  # Charts
  fl_chart: ^0.69.2
  
  # Export
  csv: ^6.0.0
  pdf: ^3.11.1
```

---

## 🔒 Security

**Features**:
- JWT-based authentication
- Role-based access control (RBAC)
- Action logging
- Session timeout
- HTTPS enforcement (production)

---

<div align="center">

**🦊 Awhar Butler Admin Dashboard**

*Built with Flutter Web*

[Main Repository](https://github.com/FouadABT/awhar-butler) • [Backend](../awhar_server/)

</div>
