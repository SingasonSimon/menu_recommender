
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SkeletonLoader extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}

class RecipeCardSkeleton extends StatelessWidget {
  const RecipeCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonLoader(
            height: 180,
            width: double.infinity,
            borderRadius: BorderRadius.zero,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLoader(height: 16, width: double.infinity),
                const SizedBox(height: 8),
                const SkeletonLoader(height: 12, width: 100),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SkeletonLoader(height: 20, width: 20, borderRadius: BorderRadius.all(Radius.circular(10))),
                    const SizedBox(width: 8),
                    const Expanded(child: SkeletonLoader(height: 12, width: 80)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

