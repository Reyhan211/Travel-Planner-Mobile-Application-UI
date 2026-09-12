import 'package:flutter/material.dart';

// Warna-warna yang dipakai di halaman home
const Color kFieldBackground = Color(0xFF1E1E1E);
const Color kChipBackground = Color(0xFF1E1E1E);
const Color kHintColor = Color(0xFF8A8A8A);
const Color kSubtitleColor = Color(0xFF9C9C9C);

/// Data sederhana untuk 1 kartu destinasi
class _Destination {
  final String title;
  final String imageUrl;

  const _Destination(this.title, this.imageUrl);
}

/// ScrollBehavior kustom: menghilangkan animasi "mentul/melebar" (stretch)
/// dan efek cahaya (glow) bawaan Android saat scroll mentok di ujung.
class _NoOverscrollBehavior extends ScrollBehavior {
  const _NoOverscrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Return child apa adanya, tanpa indikator overscroll sama sekali.
    return child;
  }
}

/// Halaman Home ("Where do you want to go?")
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 0 = Hotels, 1 = Restaurants
  int _selectedCategory = 0;

  // Index tab aktif di bottom navigation
  int _selectedNavIndex = 0;

  // Data dummy, nanti bisa diganti dari API
  final List<_Destination> _youMightLike = const [
    _Destination(
      'Ferris Wheel',
      'https://images.unsplash.com/photo-1533929736458-ca588d08c8be?w=400',
    ),
    _Destination(
      'Japan Temple',
      'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=400',
    ),
  ];

  final List<_Destination> _topInCalifornia = const [
    _Destination(
      'Street View',
      'https://images.unsplash.com/photo-1506146332389-18140dc7b2fb?w=400',
    ),
    _Destination(
      'Hollywood',
      'https://images.unsplash.com/photo-1515896769750-31548aa180ed?w=400',
    ),
  ];

  final List<_Destination> _bestPlaces = const [
    _Destination(
      'Coastal Town',
      'https://images.unsplash.com/photo-1500835556837-99ac94a94552?w=400',
    ),
    _Destination(
      'Tropical Dock',
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ScrollConfiguration di sini buat menghilangkan efek "mentul/melebar"
        // (stretch/glow) bawaan Android saat scroll mentok di atas/bawah.
        child: ScrollConfiguration(
          behavior: const _NoOverscrollBehavior(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul + tombol globe di kanan
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Where do you\nwant to go?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.public,
                          color: Colors.black, size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search bar
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: kFieldBackground,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: kHintColor),
                      hintText: 'Places want to go, things to do, hotels',
                      hintStyle: TextStyle(color: kHintColor, fontSize: 13),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Chip Hotels / Restaurants
                Row(
                  children: [
                    _buildCategoryChip('Hotels', 0),
                    const SizedBox(width: 12),
                    _buildCategoryChip('Restaurants', 1),
                  ],
                ),
                const SizedBox(height: 28),

                // Nearby location + map
                const Text(
                  'Nearby location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildMapPlaceholder(),
                const SizedBox(height: 28),

                // Section: Destination you might like
                _buildSectionHeader('Destination you might like'),
                const SizedBox(height: 12),
                _buildDestinationRow(_youMightLike),
                const SizedBox(height: 28),

                // Section: Top places to go in California
                _buildSectionHeader('Top places to go in California'),
                const SizedBox(height: 12),
                _buildDestinationRow(_topInCalifornia),
                const SizedBox(height: 28),

                // Section: Best places to go
                _buildSectionHeader('Best places to go'),
                const SizedBox(height: 12),
                _buildDestinationRow(_bestPlaces),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Chip pill untuk kategori (Hotels / Restaurants)
  Widget _buildCategoryChip(String label, int index) {
    final bool isSelected = _selectedCategory == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : kChipBackground,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Placeholder peta (bisa diganti widget Google Maps asli nanti)
  Widget _buildMapPlaceholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 130,
        width: double.infinity,
        color: const Color(0xFFBFD8C4), // hijau muda ala peta
        child: Stack(
          alignment: Alignment.center,
          children: [
            // TODO: ganti dengan widget peta asli (misal package google_maps_flutter)
            Image.network(
              'https://staticmap.openstreetmap.de/staticmap.php?center=37.7749,-122.4194&zoom=13&size=600x260&maptype=mapnik',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 130,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.map_outlined,
                color: Colors.black54,
                size: 40,
              ),
            ),
            const Icon(Icons.location_on, color: Colors.redAccent, size: 32),
          ],
        ),
      ),
    );
  }

  // Header section dengan judul + "View all"
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          'View all',
          style: TextStyle(
            color: kSubtitleColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Baris 2 kartu destinasi (gambar + judul di atasnya)
  Widget _buildDestinationRow(List<_Destination> destinations) {
    return Row(
      children: [
        for (int i = 0; i < destinations.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(child: _buildDestinationCard(destinations[i])),
        ],
      ],
    );
  }

  Widget _buildDestinationCard(_Destination destination) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              destination.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: kFieldBackground,
                child: const Icon(Icons.image_outlined,
                    color: kHintColor, size: 32),
              ),
            ),
          ),
          // Gradasi gelap tipis di bawah biar judul kebaca
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
              child: Text(
                destination.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom navigation bar dengan 5 menu
  Widget _buildBottomNav() {
    final items = [
      (Icons.explore_outlined, 'Explore'),
      (Icons.location_on_outlined, 'Nearby'),
      (Icons.favorite_border, 'My Trips'),
      (Icons.calculate_outlined, 'Calculator'),
      (Icons.person_outline, 'Profile'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0E0E0E),
        border: Border(top: BorderSide(color: kFieldBackground, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final bool isSelected = _selectedNavIndex == index;
          final (icon, label) = items[index];
          return GestureDetector(
            onTap: () {
              setState(() => _selectedNavIndex = index);
              if (index == 2) {
                // Index 2 = My Trips
                Navigator.of(context).pushNamed('/trips');
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : kHintColor,
                  size: 22,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : kHintColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
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
