import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/help_sos_feed.dart';
import 'help_sos_action_button.dart';

class HelpSosAlertView extends StatelessWidget {
  final HelpSosAlert alert;
  final VoidCallback onClose;
  final VoidCallback onGoToLocation;
  final VoidCallback onCallNow;

  const HelpSosAlertView({
    super.key,
    required this.alert,
    required this.onClose,
    required this.onGoToLocation,
    required this.onCallNow,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 26, 26, 32),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Spacer(),
                Text(
                  alert.headerTitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.35,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onClose,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 22,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 84),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppSemanticColors.primary,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            width: 45,
                            height: 45,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE7E2DF),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: PrimitiveStateColors.error500,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.priority_high_rounded,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              alert.receivedLabel,
                              style: AppTextStyles.caption.copyWith(
                                color: AppSemanticColors.primary,
                                fontSize: 10,
                                letterSpacing: 0.25,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              alert.senderName,
                              style: AppTextStyles.heading6.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1, color: NeutralColors.neutral600),
                  const SizedBox(height: 18),
                  Text(
                    alert.emergencyLabel,
                    style: AppTextStyles.caption.copyWith(
                      color: NeutralColors.neutral600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        _iconFor(alert.iconKey),
                        size: 22,
                        color: AppColors.textPrimary,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          alert.emergencyTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading5.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    alert.emergencyDescription,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption.copyWith(
                      color: NeutralColors.neutral600,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      height: 171,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset('assets/images/map.png', fit: BoxFit.cover),
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.18),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                    color: AppSemanticColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.navigation_rounded,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        alert.mapLocationLabel,
                                        style: AppTextStyles.body2.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        alert.routeDistanceLabel,
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            HelpSosActionButton(
              label: alert.primaryActionLabel,
              icon: Icons.navigation_rounded,
              isPrimary: true,
              onTap: onGoToLocation,
            ),
            const SizedBox(height: 10),
            HelpSosActionButton(
              label: alert.secondaryActionLabel,
              icon: Icons.call_rounded,
              isPrimary: false,
              onTap: onCallNow,
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'medical':
        return Icons.medical_services_rounded;
      case 'lost':
        return Icons.explore_off_rounded;
      case 'unsafe':
        return Icons.security_rounded;
      case 'vehicle':
      default:
        return Icons.directions_car_filled_rounded;
    }
  }
}
