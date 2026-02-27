import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

/// Navigation item configuration model
class NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Widget screen;

  const NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.screen,
  });
}

/// Configuration for role-based bottom navigation
class NavigationConfig {
  /// Client navigation items: Home, Explore, Orders, Messages, Profile
  static List<NavItem> getClientNavigation({
    required Widget homeScreen,
    required Widget exploreScreen,
    required Widget ordersScreen,
    required Widget messagesScreen,
    required Widget profileScreen,
  }) {
    return [
      NavItem(
        label: 'home.title',
        icon: Iconsax.home_2,
        activeIcon: Iconsax.home,
        screen: homeScreen,
      ),
      NavItem(
        label: 'client.explore.title',
        icon: Iconsax.search_normal,
        activeIcon: Iconsax.search_normal,
        screen: exploreScreen,
      ),
      NavItem(
        label: 'client.orders.title',
        icon: Iconsax.box,
        activeIcon: Iconsax.box,
        screen: ordersScreen,
      ),
      NavItem(
        label: 'messages.title',
        icon: Iconsax.message,
        activeIcon: Iconsax.message,
        screen: messagesScreen,
      ),
      NavItem(
        label: 'profile.title',
        icon: Iconsax.profile_circle,
        activeIcon: Iconsax.user,
        screen: profileScreen,
      ),
    ];
  }

  /// Driver navigation items: Dashboard, Rides, Earnings, Messages, Profile
  static List<NavItem> getDriverNavigation({
    required Widget dashboardScreen,
    required Widget ridesScreen,
    required Widget earningsScreen,
    required Widget messagesScreen,
    required Widget profileScreen,
  }) {
    return [
      NavItem(
        label: 'driver.dashboard.title',
        icon: Iconsax.element_3,
        activeIcon: Iconsax.element_3,
        screen: dashboardScreen,
      ),
      NavItem(
        label: 'driver.rides.title',
        icon: Iconsax.car,
        activeIcon: Iconsax.car,
        screen: ridesScreen,
      ),
      NavItem(
        label: 'driver.earnings.title',
        icon: Iconsax.wallet_2,
        activeIcon: Iconsax.wallet,
        screen: earningsScreen,
      ),
      NavItem(
        label: 'messages.title',
        icon: Iconsax.message,
        activeIcon: Iconsax.messages,
        screen: messagesScreen,
      ),
      NavItem(
        label: 'profile.title',
        icon: Iconsax.profile_circle,
        activeIcon: Iconsax.user,
        screen: profileScreen,
      ),
    ];
  }

  /// Get navigation based on user role
  static List<NavItem> getNavigationForRole({
    required UserRole role,
    required Widget homeScreen,
    required Widget exploreScreen,
    required Widget ordersScreen,
    required Widget dashboardScreen,
    required Widget ridesScreen,
    required Widget earningsScreen,
    required Widget messagesScreen,
    required Widget profileScreen,
  }) {
    switch (role) {
      case UserRole.driver:
        return getDriverNavigation(
          dashboardScreen: dashboardScreen,
          ridesScreen: ridesScreen,
          earningsScreen: earningsScreen,
          messagesScreen: messagesScreen,
          profileScreen: profileScreen,
        );
      case UserRole.client:
      case UserRole.admin:
      case UserRole.store:
        return getClientNavigation(
          homeScreen: homeScreen,
          exploreScreen: exploreScreen,
          ordersScreen: ordersScreen,
          messagesScreen: messagesScreen,
          profileScreen: profileScreen,
        );
    }
  }
}
