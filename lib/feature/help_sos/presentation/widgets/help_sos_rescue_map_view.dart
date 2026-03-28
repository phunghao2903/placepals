import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../map/presentation/widgets/map_action_button.dart';
import '../../domain/entities/help_sos_feed.dart';
import 'help_sos_action_button.dart';

class HelpSosRescueMapView extends StatelessWidget {
  final HelpSosRescueMap rescueMap;
  final VoidCallback onBack;
  final VoidCallback onCallNow;
  final VoidCallback onImHere;
  final bool hasArrived;

  const HelpSosRescueMapView({
    super.key,
    required this.rescueMap,
    required this.onBack,
    required this.onCallNow,
    required this.onImHere,
    required this.hasArrived,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 474,
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
                          Colors.white.withOpacity(0.08),
                          Colors.white.withOpacity(0.16),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: onBack,
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: <Widget>[
                                Text(
                                  rescueMap.title,
                                  style: AppTextStyles.heading6.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  rescueMap.cityLabel,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppSemanticColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.refresh_rounded,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Color(0x12000000),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.search_rounded,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  rescueMap.searchLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  right: 16,
                  top: 110,
                  child: Column(
                    children: <Widget>[
                      MapActionButton(icon: Icons.my_location_rounded),
                      SizedBox(height: 10),
                      MapActionButton(icon: Icons.add_rounded),
                      SizedBox(height: 10),
                      MapActionButton(icon: Icons.remove_rounded),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: AppSemanticColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.navigation_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color(0x12000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          rescueMap.searchLabel,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 52,
                      height: 5,
                      decoration: BoxDecoration(
                        color: NeutralColors.neutral500,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x12000000),
                            blurRadius: 14,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 52,
                            height: 52,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppSemanticColors.primary,
                                width: 1.3,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        rescueMap.helperName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.body2.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      rescueMap.helperStatus,
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppSemanticColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  rescueMap.helperAddress,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.caption.copyWith(
                                    color: NeutralColors.neutral700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  rescueMap.helperBattery,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppSemanticColors.primary,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: HelpSosActionButton(
                            label: rescueMap.callNowLabel,
                            icon: Icons.call_rounded,
                            isPrimary: false,
                            onTap: onCallNow,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: HelpSosActionButton(
                            label:
                                hasArrived ? 'Arrived' : rescueMap.imHereLabel,
                            icon: Icons.favorite_rounded,
                            isPrimary: true,
                            onTap: onImHere,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      hasArrived
                          ? 'You marked yourself as available on-site.'
                          : rescueMap.noteLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: NeutralColors.neutral700,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
