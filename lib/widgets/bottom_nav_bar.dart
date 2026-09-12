import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/explore_screen.dart';
import '../screens/restaurants_screen.dart';
import '../screens/my_trips_screen.dart';
import '../screens/currency_converter_screen.dart';
import '../screens/profile_screen.dart';
import 'page_transitions.dart';

/// Bottom nav bar dengan 5 tab, dipakai di semua halaman utama
/// (Explore, Nearby/Restaurants, My Trips, Currency, Profile).
///
/// Widget ini StatelessWidget murni: index aktif dikirim dari luar
/// (currentIndex), tidak disimpan sebagai state di sini. Perpindahan
/// antar tab dilakukan lewat Navigator.pushReplacement + fade transition,
/// jadi tiap tab tetap halaman baru yang "stateless", bukan disimpan
/// hidup di IndexedStack.
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({super.key, required this.currentIndex});

  static const _items = [
    _NavItemData(icon: Icons.search, label: 'Explore'),
    _NavItemData(icon: Icons.near_me_outlined, label: 'Nearby'),
    _NavItemData(icon: Icons.favorite_border, label: 'My Trips'),
    _NavItemData(icon: Icons.calculate_outlined, label: 'Calculator'),
    _NavItemData(icon: Icons.person_outline, label: 'Profile'),
  ];

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    late final Widget destination;
    switch (index) {
      case 0:
        destination = const ExploreScreen();
        break;
      case 1:
        destination = const RestaurantsScreen();
        break;
      case 2:
        destination = MyTripsScreen();
        break;
      case 3:
        destination = const CurrencyConverterScreen();
        break;
      default:
        destination = const ProfileScreen();
    }

    Navigator.of(context).pushReplacement(fadeTransition(destination));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final isActive = index == currentIndex;
          final item = _items[index];
          return GestureDetector(
            onTap: () => _onTap(context, index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  size: 22,
                  color: isActive ? AppColors.white : AppColors.textSecondary,
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 11,
                    color: isActive ? AppColors.white : AppColors.textSecondary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  const _NavItemData({required this.icon, required this.label});
}
