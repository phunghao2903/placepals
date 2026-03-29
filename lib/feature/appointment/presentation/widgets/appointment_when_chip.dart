import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentWhenChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSoft;

  const AppointmentWhenChip({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSoft = true,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isSoft ? const Color(0x1AFA8075) : Colors.white;
    final borderColor =
        isSoft ? Colors.transparent : const Color(0xFFE2E8F0);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(
            horizontal: isSoft ? 17 : 12.5,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: isSoft ? 17 : 15, color: const Color(0xFFFA8075)),
              if (label.isNotEmpty) ...<Widget>[
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFA8075),
                      height: 1.43,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
