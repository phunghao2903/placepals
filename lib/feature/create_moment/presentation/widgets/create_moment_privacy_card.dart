import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/create_moment_privacy_option.dart';

class CreateMomentPrivacyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<CreateMomentPrivacyOption> options;
  final String selectedId;
  final ValueChanged<String> onSelected;

  const CreateMomentPrivacyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.selectedId,
    required this.onSelected,
  });

  static const Color _cardBackground = Color(0xFFF7F0EE);
  static const Color _warmShadow = Color(0x26FA7E72);
  static const Color _iconBackground = Color(0x1AF27F0D);
  static const Color _iconColor = Color(0xFFFF6B5A);
  static const Color _titleColor = Color(0xFF2D2D2D);
  static const Color _subtitleColor = Color(0xFF9C9493);
  static const Color _segmentBackground = Color(0xFF9C9493);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: _warmShadow, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: _iconBackground,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: _iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _segmentBackground,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: options
                  .map(
                    (option) => Expanded(
                      child: GestureDetector(
                        onTap: () => onSelected(option.id),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOut,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: option.id == selectedId
                                ? const Color(0xFFFF6B5A)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: option.id == selectedId
                                ? const <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            option.label,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}
