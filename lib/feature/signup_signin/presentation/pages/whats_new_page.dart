import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../widgets/auth_primary_button.dart';
import 'auth_gate_page.dart';

class WhatsNewPage extends StatelessWidget {
  const WhatsNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 390),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () => _goToWelcome(context),
                              borderRadius: BorderRadius.circular(999),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 18,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 325,
                            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  AppColors.primary.withValues(alpha: 0.18),
                                  const Color(0xFFFFECE7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.18,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.map_outlined,
                                    size: 24,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _MiniBadge(
                                      icon: Icons.people_alt_outlined,
                                      color: AppColors.primary.withValues(
                                        alpha: 0.88,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    _MiniBadge(
                                      icon: Icons.location_on_outlined,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            "What's New in\nPlacePals",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.heading4.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const SizedBox(
                            width: 325,
                            child: Column(
                              children: <Widget>[
                                _WhatsNewItem(
                                  icon: Icons.auto_awesome_rounded,
                                  title: 'AI Location\nRecommendations',
                                  description:
                                      'Personalized spots discovered just\nfor you based on your travel\nstyle.',
                                ),
                                SizedBox(height: 18),
                                _WhatsNewItem(
                                  icon: Icons.campaign_rounded,
                                  title: 'SOS Help Requests',
                                  description:
                                      'Reach out to nearby Pals instantly if\nyou ever need a hand or directions.',
                                ),
                                SizedBox(height: 18),
                                _WhatsNewItem(
                                  icon: Icons.sentiment_satisfied_rounded,
                                  title: 'Vibe Match Search',
                                  description:
                                      'Find places that match your current\nmood, from chill cafes to high-\nenergy hubs.',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 36),
                          SizedBox(
                            width: 325,
                            child: AuthPrimaryButton(
                              label: AppStrings.continueToApp,
                              onTap: () => _goToWelcome(context),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 230,
                            child: Text(
                              'By continuing, you agree to discover the best of your city with PlacePals community.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 9,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _goToWelcome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const AuthGatePage()),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _MiniBadge({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }
}

class _WhatsNewItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _WhatsNewItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 15, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
