import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/sos_feed.dart';

class SosIntroView extends StatelessWidget {
  final SosIntroContent intro;
  final VoidCallback onPrimaryAction;
  final VoidCallback onClose;

  const SosIntroView({
    super.key,
    required this.intro,
    required this.onPrimaryAction,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double outerRingSize = math.min(constraints.maxWidth - 16, 392);
          final double middleRingSize = outerRingSize * 0.76;
          final double buttonSize = outerRingSize * 0.54;

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onClose,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.close_rounded,
                          size: 28,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: onClose,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      child: Text(
                        intro.trailingActionLabel,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: outerRingSize,
                      height: outerRingSize + 48,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: outerRingSize,
                            height: outerRingSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: BrandColors.primary50.withOpacity(0.38),
                            ),
                          ),
                          Container(
                            width: middleRingSize,
                            height: middleRingSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: BrandColors.primary100.withOpacity(0.48),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: onPrimaryAction,
                              onLongPress: onPrimaryAction,
                              child: Container(
                                width: buttonSize,
                                height: buttonSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: BrandColors.primary400,
                                  border: Border.all(
                                    color: BrandColors.primary500,
                                    width: 2.4,
                                  ),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0x40FF6B5A),
                                      blurRadius: 36,
                                      offset: Offset(0, 20),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        intro.heroLabel,
                                        style: AppTextStyles.heading1.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          height: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const _SosSignalIcon(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: buttonSize / 2,
                            right: buttonSize / 2,
                            bottom: 6,
                            child: Text(
                              intro.helperText,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.body2.copyWith(
                                color: NeutralColors.neutral700,
                                fontSize: 14,
                                height: 1.32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 108,
                  height: 4,
                  decoration: BoxDecoration(
                    color: NeutralColors.neutral500,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SosSignalIcon extends StatelessWidget {
  const _SosSignalIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      height: 26,
      child: Stack(
        alignment: Alignment.center,
        children: const <Widget>[
          Positioned(
            top: 0,
            child: Icon(
              Icons.wifi_tethering_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Icon(
              Icons.location_on_rounded,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
