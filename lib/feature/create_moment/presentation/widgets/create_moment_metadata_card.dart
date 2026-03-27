import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateMomentMetadataCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const CreateMomentMetadataCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  static const Color _cardBackground = Color(0xFFF7F0EE);
  static const Color _warmShadow = Color(0x26FA7E72);
  static const Color _iconBackground = Color(0x1AF27F0D);
  static const Color _iconColor = Color(0xFFFF6B5A);
  static const Color _titleColor = Color(0xFF2D2D2D);
  static const Color _subtitleColor = Color(0xFF9C9493);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _cardBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: _warmShadow,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: _iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: _iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: _subtitleColor,
                    size: 20,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
