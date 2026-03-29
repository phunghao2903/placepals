import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class CreateMomentPhotoTile extends StatelessWidget {
  final String? imagePath;
  final String label;
  final bool isPlaceholder;
  final int selectionBadge;
  final VoidCallback onTap;

  const CreateMomentPhotoTile({
    super.key,
    required this.imagePath,
    required this.label,
    required this.isPlaceholder,
    required this.selectionBadge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Ink(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: isPlaceholder
              ? _PlaceholderTile(label: label)
              : _ImageTile(
                  imagePath: imagePath,
                  selectionBadge: selectionBadge,
                ),
        ),
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  final String? imagePath;
  final int selectionBadge;

  const _ImageTile({required this.imagePath, required this.selectionBadge});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (imagePath != null)
            Image.asset(imagePath!, fit: BoxFit.cover)
          else
            Container(color: AppColors.surfaceMuted),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Color(0x99000000),
                shape: BoxShape.circle,
              ),
              child: Icon(
                selectionBadge > 0
                    ? Icons.collections_rounded
                    : Icons.edit_rounded,
                color: SemanticTextColors.onBrand,
                size: 16,
              ),
            ),
          ),
          if (selectionBadge > 1)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '+${selectionBadge - 1}',
                  style: AppTextStyles.caption.copyWith(
                    color: SemanticTextColors.onBrand,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlaceholderTile extends StatelessWidget {
  final String label;

  const _PlaceholderTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: AppColors.textSecondary, radius: 30),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceSoft,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: AppSemanticColors.secondary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              label,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  const _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final path = Path()..addRRect(rect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
