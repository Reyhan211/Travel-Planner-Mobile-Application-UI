import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';

/// Card kotak untuk destinasi, dipakai di dalam horizontal ListView
/// di Explore Screen ("Destination you might like", "Top places", dst).
class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;
  final double width;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                destination.imageUrl,
                height: 110,
                width: width,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 110,
                    width: width,
                    color: AppColors.surface,
                  );
                },
                errorBuilder: (context, error, stack) => Container(
                  height: 110,
                  width: width,
                  color: AppColors.surface,
                  child: const Icon(Icons.image_not_supported_outlined,
                      color: AppColors.textSecondary),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              destination.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card horizontal (foto besar) untuk daftar hotel / restoran,
/// dipakai di Hotels Screen dan Restaurants Screen.
class ListingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? trailingText;

  const ListingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              imageUrl,
              height: 120,
              width: 170,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(height: 120, width: 170, color: AppColors.surface);
              },
              errorBuilder: (context, error, stack) => Container(
                height: 120,
                width: 170,
                color: AppColors.surface,
                child: const Icon(Icons.image_not_supported_outlined,
                    color: AppColors.textSecondary),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          if (trailingText != null)
            Text(
              trailingText!,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
