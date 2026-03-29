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
          SizedBox(
            height: 360,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SafeArea(
                      bottom: false,
                      child: Container(
                        height: 82,
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                        color: Colors.white,
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
                                    Colors.white.withOpacity(0.08),
                                    Colors.white.withOpacity(0.12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  right: 16,
                  top: 144,
                  child: _MapZoomControls(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 112,
                  child: _AlertLocationBadge(
                    city: alert.city,
                    locationName: alert.locationName,
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
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 52,
                          height: 5,
                          decoration: BoxDecoration(
                            color: NeutralColors.neutral500,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        alert.respondersTitle,
                        style: AppTextStyles.heading6.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 280),
                          child: showResponders
                              ? ListView.separated(
                                  key: const ValueKey<String>('responders'),
                                  itemCount: alert.responders.length,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final responder = alert.responders[index];
                                    return SosActiveResponderTile(
                                      responder: responder,
                                    );
                                  },
                                )
                              : Center(
                                  key: const ValueKey<String>('empty'),
                                  child: Text(
                                    alert.respondersEmptyLabel,
                                    style: AppTextStyles.body2.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
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
                            Icons.shield_outlined,
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
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          alert.holdToCancelLabel,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption.copyWith(
                            color: AppSemanticColors.primary,
                            fontSize: 10,
                            letterSpacing: 0.35,
                          ),
                        ),
                      ),
                    ],
                  ),
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
  final String city;
  final String locationName;

  const _AlertLocationBadge({
    required this.city,
    required this.locationName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 182,
              height: 182,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BrandColors.primary500.withOpacity(0.28),
              ),
              child: Center(
                child: Text(
                  city.replaceFirst(' City', '').replaceAll(' ', '\n'),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading4.copyWith(
                    color: const Color(0xFF40241D),
                    fontWeight: FontWeight.w600,
                    height: 0.95,
                  ),
                ),
              ),
            ),
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: const BoxDecoration(
                  color: BrandColors.primary500,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -18,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 286),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  locationName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading6.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
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
        _RoundIconButton(icon: Icons.my_location_rounded),
        SizedBox(height: 12),
        _RoundIconButton(icon: Icons.add_rounded),
        SizedBox(height: 2),
        _RoundIconButton(icon: Icons.remove_rounded),
      ],
    );
  }
}
