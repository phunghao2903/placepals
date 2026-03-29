import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/help_sos_feed.dart';

class HelpSosCallView extends StatelessWidget {
  final HelpSosCallSession session;
  final VoidCallback onEndCall;

  const HelpSosCallView({
    super.key,
    required this.session,
    required this.onEndCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF4D4745),
            Color(0xFF2E2A29),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 46, 32, 22),
          child: Column(
            children: <Widget>[
              const Spacer(),
              Container(
                width: 88,
                height: 88,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppSemanticColors.primary,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                session.participantName,
                style: AppTextStyles.heading5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                session.statusLabel,
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white.withOpacity(0.72),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _CallControlButton(
                    icon: Icons.volume_up_rounded,
                    backgroundColor: Colors.white.withOpacity(0.18),
                    iconColor: Colors.white,
                    onTap: () {},
                  ),
                  const SizedBox(width: 24),
                  _CallControlButton(
                    icon: Icons.call_end_rounded,
                    backgroundColor: const Color(0xFFFF3B30),
                    iconColor: Colors.white,
                    onTap: onEndCall,
                  ),
                  const SizedBox(width: 24),
                  _CallControlButton(
                    icon: Icons.mic_off_rounded,
                    backgroundColor: Colors.white.withOpacity(0.18),
                    iconColor: Colors.white,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Container(
                width: 110,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _CallControlButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 22,
          color: iconColor,
        ),
      ),
    );
  }
}
