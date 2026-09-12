import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/place_cards.dart';

/// Halaman: Hotels ("Rent your place to stay").
/// Diakses dari tombol "Hotels" di Explore Screen.
class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Hotels', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            const Text('Rent your\nplace to stay', style: TextStyle(
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
            const Text('Popular Hotels',
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
                  imageUrl: hotels[0].imageUrl,
                  title: hotels[0].name,
                  subtitle: hotels[0].location,
                  trailingText: hotels[0].price,
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
                itemCount: hotels.length - 1,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final hotel = hotels[index + 1];
                  return ListingCard(
                    imageUrl: hotel.imageUrl,
                    title: hotel.name,
                    subtitle: hotel.location,
                    trailingText: hotel.price,
                  );
                },
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
