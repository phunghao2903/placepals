import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/sos_feed.dart';
import 'sos_active_responder_tile.dart';

class SosActiveAlertView extends StatelessWidget {
  final SosActiveAlert alert;
  final bool showResponders;
  final VoidCallback onBack;
  final VoidCallback onMarkSafe;

  const SosActiveAlertView({
    super.key,
    required this.alert,
    required this.showResponders,
    required this.onBack,
    required this.onMarkSafe,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Expanded(
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
                          Colors.white.withOpacity(0.55),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _RoundIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: onBack,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                alert.title,
                                style: AppTextStyles.heading6.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                alert.city,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppSemanticColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const _RoundIconButton(
                          icon: Icons.warning_amber_rounded,
                          iconColor: PrimitiveStateColors.warning500,
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: _AlertLocationBadge(
                    locationPrefix: alert.locationPrefix,
                    locationName: alert.locationName,
                  ),
                ),
                const Positioned(
                  right: 16,
                  bottom: 24,
                  child: _MapZoomControls(),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 18,
                  offset: Offset(0, -6),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      alert.respondersTitle,
                      style: AppTextStyles.heading6.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 280),
                      child: showResponders
                          ? Column(
                              key: const ValueKey<String>('responders'),
                              children: alert.responders
                                  .map(
                                    (responder) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: responder == alert.responders.last
                                            ? 0
                                            : 12,
                                      ),
                                      child: SosActiveResponderTile(
                                        responder: responder,
                                      ),
                                    ),
                                  )
                                  .toList(growable: false),
                            )
                          : Container(
                              key: const ValueKey<String>('empty'),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              alignment: Alignment.center,
                              child: Text(
                                alert.respondersEmptyLabel,
                                style: AppTextStyles.body2.copyWith(
                                  color: NeutralColors.neutral700,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: onMarkSafe,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppSemanticColors.primary,
                          side: const BorderSide(
                            color: BrandColors.primary500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          size: 18,
                        ),
                        label: Text(
                          alert.markSafeLabel,
                          style: AppTextStyles.body2.copyWith(
                            color: AppSemanticColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        alert.holdToCancelLabel,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption.copyWith(
                          color: NeutralColors.neutral700,
                          fontSize: 10,
                          letterSpacing: 0.25,
                        ),
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

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color iconColor;

  const _RoundIconButton({
    required this.icon,
    this.onTap,
    this.iconColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final Widget child = Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, size: 18, color: iconColor),
    );

    if (onTap == null) {
      return child;
    }

    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}

class _AlertLocationBadge extends StatelessWidget {
  final String locationPrefix;
  final String locationName;

  const _AlertLocationBadge({
    required this.locationPrefix,
    required this.locationName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 132,
          height: 132,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: BrandColors.primary100.withOpacity(0.75),
            border: Border.all(
              color: BrandColors.primary500,
              width: 1.5,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33FF6B5A),
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 78,
              height: 78,
              decoration: const BoxDecoration(
                color: BrandColors.primary500,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sos_rounded,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          constraints: const BoxConstraints(maxWidth: 220),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                locationPrefix,
                style: AppTextStyles.caption.copyWith(
                  color: AppSemanticColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                locationName,
                textAlign: TextAlign.center,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapZoomControls extends StatelessWidget {
  const _MapZoomControls();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _RoundIconButton(icon: Icons.add_rounded),
        SizedBox(height: 8),
        _RoundIconButton(icon: Icons.remove_rounded),
      ],
    );
  }
}
