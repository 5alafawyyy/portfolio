import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool isCircular;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    this.height = 12,
    this.borderRadius = 8,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
          Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkSurface
              : Colors.grey[300]!,
      highlightColor:
          Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkSurface.withValues(alpha:0.5)
              : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircular ? null : BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class ShimmerProjectCard extends StatelessWidget {
  const ShimmerProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: ShimmerLoading(width: 64, height: 64, isCircular: true),
            ),
            const SizedBox(height: 16),
            const ShimmerLoading(width: 200, height: 24),
            const SizedBox(height: 8),
            const ShimmerLoading(width: double.infinity, height: 16),
            const SizedBox(height: 8),
            const ShimmerLoading(width: double.infinity, height: 16),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ShimmerLoading(
                    width: 80,
                    height: 32,
                    borderRadius: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerProfileCard extends StatelessWidget {
  const ShimmerProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const ShimmerLoading(width: 120, height: 120, isCircular: true),
            const SizedBox(height: 24),
            const ShimmerLoading(width: 200, height: 32),
            const SizedBox(height: 8),
            const ShimmerLoading(width: 150, height: 24),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ShimmerLoading(
                    width: 40,
                    height: 40,
                    isCircular: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerExperienceCard extends StatelessWidget {
  const ShimmerExperienceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerLoading(width: 150, height: 24),
            const SizedBox(height: 8),
            const ShimmerLoading(width: 200, height: 20),
            const SizedBox(height: 8),
            const ShimmerLoading(width: 100, height: 16),
            const SizedBox(height: 16),
            ...List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ShimmerLoading(width: double.infinity, height: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerEducationCard extends StatelessWidget {
  const ShimmerEducationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerLoading(width: 200, height: 24),
            const SizedBox(height: 8),
            const ShimmerLoading(width: 250, height: 20),
            const SizedBox(height: 8),
            const ShimmerLoading(width: 100, height: 16),
          ],
        ),
      ),
    );
  }
}

class ShimmerCertificateCard extends StatelessWidget {
  const ShimmerCertificateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerLoading(width: 200, height: 24),
            const SizedBox(height: 8),
            const ShimmerLoading(width: 150, height: 20),
            const SizedBox(height: 8),
            const ShimmerLoading(width: 100, height: 16),
          ],
        ),
      ),
    );
  }
}
