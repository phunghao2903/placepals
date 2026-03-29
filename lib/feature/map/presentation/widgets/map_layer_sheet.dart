import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/map_overlay_setting.dart';
import '../../domain/entities/map_style_option.dart';

class MapLayerSheet extends StatelessWidget {
  final List<MapStyleOption> styleOptions;
  final List<MapOverlaySetting> overlaySettings;
  final VoidCallback onClose;
  final ValueChanged<String> onStyleSelected;
  final ValueChanged<String> onOverlayToggled;

  const MapLayerSheet({
    super.key,
    required this.styleOptions,
    required this.overlaySettings,
    required this.onClose,
    required this.onStyleSelected,
    required this.onOverlayToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              child: Container(
                width: 82,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E0DF),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Map Layer Settings',
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onClose,
                  child: Text(
                    'x',
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.iconBackground,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: styleOptions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 24,
                childAspectRatio: 168 / 126,
              ),
              itemBuilder: (context, index) {
                final option = styleOptions[index];
                return _MapStyleCard(
                  option: option,
                  onTap: () => onStyleSelected(option.id),
                );
              },
            ),
            const SizedBox(height: 18),
            Text(
              'OVERLAYS',
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 14),
            ...overlaySettings.map(
              (setting) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _OverlayTile(
                  setting: setting,
                  onChanged: () => onOverlayToggled(setting.id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapStyleCard extends StatelessWidget {
  final MapStyleOption option;
  final VoidCallback onTap;

  const _MapStyleCard({required this.option, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            height: 98,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: option.isSelected
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
              gradient: _gradientFor(option.type),
              color: option.type == MapStyleType.standard ? Colors.white : null,
            ),
            child: _stylePreview(option),
          ),
          const SizedBox(height: 8),
          Text(
            option.title,
            style: AppTextStyles.body1.copyWith(
              color: option.isSelected
                  ? AppColors.primary
                  : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Gradient? _gradientFor(MapStyleType type) {
    switch (type) {
      case MapStyleType.standard:
        return null;
      case MapStyleType.satellite:
        return const LinearGradient(
          colors: <Color>[Color(0xFF6FB353), Color(0xFF0E5E1D)],
        );
      case MapStyleType.terrain:
        return const LinearGradient(
          colors: <Color>[Color(0xFFBEC2BA), Color(0xFF333B34)],
        );
      case MapStyleType.nightMode:
        return const LinearGradient(
          colors: <Color>[Color(0xFF11152F), Color(0xFF151C67)],
        );
    }
  }

  Widget _stylePreview(MapStyleOption option) {
    switch (option.type) {
      case MapStyleType.standard:
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset('assets/images/map.png', fit: BoxFit.cover),
        );
      case MapStyleType.satellite:
        return const Center(
          child: Icon(
            Icons.satellite_alt_rounded,
            size: 44,
            color: Color(0xFFB7AFA7),
          ),
        );
      case MapStyleType.terrain:
        return const Center(
          child: Icon(
            Icons.terrain_rounded,
            size: 42,
            color: Color(0xFFB7AFA7),
          ),
        );
      case MapStyleType.nightMode:
        return const Center(
          child: Icon(
            Icons.nightlight_round,
            size: 42,
            color: Color(0xFFB7AFA7),
          ),
        );
    }
  }
}

class _OverlayTile extends StatelessWidget {
  final MapOverlaySetting setting;
  final VoidCallback onChanged;

  const _OverlayTile({required this.setting, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final Color borderColor = setting.isHighlighted
        ? AppColors.primary
        : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: setting.isHighlighted ? const Color(0xFFFFF0EE) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor.withValues(
            alpha: setting.isHighlighted ? 1 : 0.55,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFF8F4F3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _iconFor(setting.iconKey),
              color: setting.isHighlighted
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  setting.title,
                  style: AppTextStyles.body1.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                if (setting.subtitle.isNotEmpty)
                  Text(
                    setting.subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: setting.isEnabled,
            onChanged: (_) => onChanged(),
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.35),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'friends':
        return Icons.group_rounded;
      case 'traffic':
        return Icons.traffic_rounded;
      case 'biking':
        return Icons.directions_bike_rounded;
      default:
        return Icons.layers_outlined;
    }
  }
}
