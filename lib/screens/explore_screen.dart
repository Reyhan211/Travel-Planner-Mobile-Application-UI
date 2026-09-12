import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/place_cards.dart';
import '../widgets/page_transitions.dart';
import 'destination_detail_screen.dart';
import 'hotels_screen.dart';
import 'restaurants_screen.dart';

/// Halaman 4: Explore ("Where do you want to go?").
/// Ini halaman utama/home setelah login.
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Where do you\nwant to go?',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    )),
                Icon(Icons.public, color: AppColors.white, size: 26),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Places want to go, things to do, hotels',
                        hintStyle: TextStyle(
                            color: AppColors.textSecondary, fontSize: 13),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _CategoryChip(
                  label: 'Hotels',
                  onTap: () => Navigator.of(context)
                      .push(slideTransition(const HotelsScreen())),
                ),
                const SizedBox(width: 10),
                _CategoryChip(
                  label: 'Restaurants',
                  onTap: () => Navigator.of(context)
                      .push(slideTransition(const RestaurantsScreen())),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SectionHeader(title: 'Nearby location', onViewAll: () {}),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://i.pinimg.com/1200x/2e/0a/78/2e0a789278de18b14b6716d8ac229677.jpg',
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  height: 110,
                  color: AppColors.surface,
                  child: const Icon(Icons.map_outlined,
                      color: AppColors.textSecondary),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _SectionHeader(
                title: 'Destination you might like', onViewAll: () {}),
            const SizedBox(height: 10),
            _DestinationRow(items: destinations.sublist(0, 2)),
            const SizedBox(height: 24),
            _SectionHeader(
                title: 'Top places to go in California', onViewAll: () {}),
            const SizedBox(height: 10),
            _DestinationRow(items: destinations.sublist(2, 4)),
            const SizedBox(height: 24),
            _SectionHeader(title: 'Best places to go', onViewAll: () {}),
            const SizedBox(height: 10),
            _DestinationRow(items: destinations.sublist(4, 6)),
            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _CategoryChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: const Text('View all',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ),
      ],
    );
  }
}

class _DestinationRow extends StatelessWidget {
  final List<Destination> items;
  const _DestinationRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((d) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DestinationCard(
              destination: d,
              width: double.infinity,
              onTap: () => Navigator.of(context).push(
                slideTransition(DestinationDetailScreen(destination: d)),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
