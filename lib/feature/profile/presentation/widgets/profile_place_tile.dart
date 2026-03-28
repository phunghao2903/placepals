import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/profile_feed.dart';
import '../pages/edit_place_page.dart';

class ProfilePlaceTile extends StatefulWidget {
  final ProfilePlaceItem place;
  final bool compact;

  const ProfilePlaceTile({
    super.key,
    required this.place,
    required this.compact,
  });

  @override
  State<ProfilePlaceTile> createState() => _ProfilePlaceTileState();
}

class _ProfilePlaceTileState extends State<ProfilePlaceTile> {
  bool _isHovered = false;
  bool _showsTouchVariant = false;

  @override
  Widget build(BuildContext context) {
    if (widget.compact) {
      return _ProfilePlaceListTile(place: widget.place, onEdit: _openEditor);
    }

    final showsEditVariant = _isHovered || _showsTouchVariant;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) {
        if (mounted) {
          setState(() {
            _isHovered = false;
          });
        }
      },
      child: GestureDetector(
        onTap: _toggleTouchVariant,
        onLongPress: _openEditor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF5EAE7)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14111827),
                blurRadius: 16,
                offset: Offset(0, 12),
                spreadRadius: -10,
              ),
              BoxShadow(
                color: Color(0x12111827),
                blurRadius: 20,
                offset: Offset(0, 18),
                spreadRadius: -18,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(widget.place.imagePath, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Color(0xBF161616),
                          Color(0x40161616),
                          Color(0x00000000),
                        ],
                        stops: <double>[0, 0.42, 1],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: showsEditVariant ? 1 : 0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF727B8E,
                          ).withValues(alpha: 0.58),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 9,
                  left: 7,
                  child: _InfoPill(
                    label: widget.place.city,
                    backgroundColor: const Color(0xE6FF6B5A),
                    height: 32,
                    horizontalPadding: 14,
                    fontSize: 12,
                  ),
                ),
                Positioned(
                  top: 13,
                  right: 7,
                  child: _InfoPill(
                    label: widget.place.rating.toStringAsFixed(1),
                    backgroundColor: const Color(0xE62D2D2D),
                    height: 24,
                    horizontalPadding: 8,
                    fontSize: 12,
                    leading: const Icon(
                      Icons.star_rounded,
                      size: 12,
                      color: AppColors.warning,
                    ),
                  ),
                ),
                Positioned(
                  top: 51,
                  left: 10,
                  child: showsEditVariant
                      ? _EditPlaceButton(onTap: _openEditor)
                      : const SizedBox.shrink(),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        widget.place.title.replaceAll('The ', ''),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.visibility_outlined,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.place.views}',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.favorite_outline_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.place.likes}',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openEditor() {
    _showsTouchVariant = false;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => EditPlacePage(place: widget.place),
      ),
    );
  }

  void _toggleTouchVariant() {
    if (_isHovered) {
      return;
    }

    setState(() {
      _showsTouchVariant = !_showsTouchVariant;
    });
  }
}

class _ProfilePlaceListTile extends StatelessWidget {
  final ProfilePlaceItem place;
  final VoidCallback onEdit;

  const _ProfilePlaceListTile({required this.place, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onEdit,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFF5EAE7)),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                place.imagePath,
                width: 110,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          place.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        place.rating.toStringAsFixed(1),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    place.city,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.visibility_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text('${place.views}', style: AppTextStyles.caption),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.favorite_outline_rounded,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text('${place.likes}', style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _EditPlaceButton(onTap: onEdit, compact: true),
          ],
        ),
      ),
    );
  }
}

class _EditPlaceButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool compact;

  const _EditPlaceButton({required this.onTap, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final size = compact ? 32.0 : 42.0;
    final iconSize = compact ? 16.0 : 22.0;

    return Material(
      color: Colors.white.withValues(alpha: 0.96),
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFB4BCC9), width: 1.5),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14111827),
                blurRadius: 14,
                offset: Offset(0, 8),
                spreadRadius: -10,
              ),
            ],
          ),
          child: Icon(
            Icons.edit_outlined,
            size: iconSize,
            color: const Color(0xFF273142),
          ),
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final Widget? leading;
  final Color backgroundColor;
  final double height;
  final double horizontalPadding;
  final double fontSize;

  const _InfoPill({
    required this.label,
    this.leading,
    this.backgroundColor = const Color(0xEBFFFFFF),
    this.height = 24,
    this.horizontalPadding = 10,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final bool darkBackground = backgroundColor.computeLuminance() < 0.6;

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (leading != null) ...<Widget>[leading!, const SizedBox(width: 4)],
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: darkBackground ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
