import 'package:get/get.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/users_screen.dart';
import '../screens/drivers_screen.dart';
import '../screens/stores_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/requests_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/transactions_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/promos_screen.dart';
import '../screens/promo_form_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/admins_screen.dart';
import '../screens/admin_form_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/strategist_screen.dart';
import '../screens/fraud_dashboard_screen.dart';
import '../screens/mcp_tools_screen.dart';

/// Admin app routes
abstract class AdminRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const notifications = '/notifications';
  static const strategist = '/strategist';
  static const fraud = '/fraud';
  static const users = '/users';
  static const drivers = '/drivers';
  static const stores = '/stores';
  static const orders = '/orders';
  static const requests = '/requests';
  static const reports = '/reports';
  static const transactions = '/transactions';
  static const settings = '/settings';
  static const promos = '/promos';
  static const promoCreate = '/promos/create';
  static const promoEdit = '/promos/edit';
  static const profile = '/profile';
  static const admins = '/admins';
  static const adminCreate = '/admins/create';
  static const adminEdit = '/admins/edit/:id';
  static const mcpTools = '/mcp-tools';
}

/// Route pages for GetX navigation
class AdminPages {
  static final pages = [
    GetPage(
      name: AdminRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AdminRoutes.dashboard,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: AdminRoutes.users,
      page: () => const UsersScreen(),
    ),
    GetPage(
      name: AdminRoutes.drivers,
      page: () => const DriversScreen(),
    ),
    GetPage(
      name: AdminRoutes.stores,
      page: () => const StoresScreen(),
    ),
    GetPage(
      name: AdminRoutes.orders,
      page: () => const OrdersScreen(),
    ),
    GetPage(
      name: AdminRoutes.requests,
      page: () => const RequestsScreen(),
    ),
    GetPage(
      name: AdminRoutes.reports,
      page: () => const ReportsScreen(),
    ),
    GetPage(
      name: AdminRoutes.transactions,
      page: () => const TransactionsScreen(),
    ),
    GetPage(
      name: AdminRoutes.settings,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: AdminRoutes.promos,
      page: () => const PromosScreen(),
    ),
    GetPage(
      name: AdminRoutes.promoCreate,
      page: () => const PromoFormScreen(),
    ),
    GetPage(
      name: AdminRoutes.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AdminRoutes.admins,
      page: () => const AdminsScreen(),
    ),
    GetPage(
      name: AdminRoutes.adminCreate,
      page: () => const AdminFormScreen(),
    ),
    GetPage(
      name: AdminRoutes.adminEdit,
      page: () => const AdminFormScreen(),
    ),
    GetPage(
      name: AdminRoutes.notifications,
      page: () => const NotificationsScreen(),
    ),
    GetPage(
      name: AdminRoutes.strategist,
      page: () => const StrategistScreen(),
    ),
    GetPage(
      name: AdminRoutes.fraud,
      page: () => const FraudDashboardScreen(),
    ),
    GetPage(
      name: AdminRoutes.mcpTools,
      page: () => const McpToolsScreen(),
    ),
  ];
}
