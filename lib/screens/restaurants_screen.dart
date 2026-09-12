import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/place_cards.dart';

/// Halaman: Restaurants ("Find the best place to eat").
/// Diakses dari tombol "Restaurants" di Explore, dan dari tab "Nearby"
/// di bottom navigation bar.
class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Restaurants', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            const Text('Find the\nbest place to eat', style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 1.2,
            )),
            const SizedBox(height: 4),
            const Text('Your location',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const Text('Tokyo, Jepang',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 13)),
            const SizedBox(height: 24),
            const Text('Popular Restaurant',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            const SizedBox(height: 12),
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) => ListingCard(
                  imageUrl: restaurants[0].imageUrl,
                  title: restaurants[0].name,
                  subtitle: restaurants[0].location,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Recommended for you',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            const SizedBox(height: 12),
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: restaurants.length - 1,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final r = restaurants[index + 1];
                  return ListingCard(
                    imageUrl: r.imageUrl,
                    title: r.name,
                    subtitle: r.location,
                  );
                },
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}
