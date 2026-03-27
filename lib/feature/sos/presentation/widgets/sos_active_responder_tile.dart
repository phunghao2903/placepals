import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/sos_feed.dart';

class SosActiveResponderTile extends StatelessWidget {
  final SosResponder responder;

  const SosActiveResponderTile({
    super.key,
    required this.responder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: ClipOval(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(responder.avatarTintHex).withOpacity(0.35),
                BlendMode.srcATop,
              ),
              child: Image.asset(
                'assets/images/profile.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                responder.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                responder.details,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption.copyWith(
                  color: NeutralColors.neutral700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          responder.etaLabel,
          style: AppTextStyles.caption.copyWith(
            color: AppSemanticColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
