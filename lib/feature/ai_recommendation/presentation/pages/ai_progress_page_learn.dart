import 'package:flutter/material.dart';
import 'package:placepals/core/theme/app_colors.dart';

class ProgressOrb extends StatefulWidget {
  const ProgressOrb({super.key});

  @override
  State<ProgressOrb> createState() => _ProgressOrbState();
}

class _ProgressOrbState extends State<ProgressOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1 + (_controller.value * 0.08);
        // final scale = 1 + _controller.value;
        return Transform.scale(scale: scale, child: child);
      },
      child: SizedBox(
        width: 160,
        height: 160,
        child: Stack(
          alignment: .center,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF4D9D4),
              ),
            ),
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFF9A66), Color(0xFFFF7A5F)],
                ),
              ),
              child: const Icon(
                Icons.auto_awesome_mosaic_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),
            const Positioned(
              top: 420,
              right: 130,
              child: Icon(
                Icons.star_border_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const Positioned(
              top: 390,
              right: 150,
              child: Icon(
                Icons.star_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const Positioned(
              top: 470,
              right: 250,
              child: Icon(
                Icons.star_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
