import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool isTextArea;
  final bool showAccentBorder;

  const AppointmentFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.initialValue,
    required this.onChanged,
    this.isTextArea = false,
    this.showAccentBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF0F172A),
      height: 1.5,
    );

    final textStyle = GoogleFonts.plusJakartaSans(
      fontSize: isTextArea ? 16 : 18,
      fontWeight: isTextArea ? FontWeight.w400 : FontWeight.w500,
      color: const Color(0xFF0F172A),
      height: isTextArea ? 1.5 : 1.28,
    );

    final hintStyle = GoogleFonts.plusJakartaSans(
      fontSize: isTextArea ? 16 : 18,
      fontWeight: isTextArea ? FontWeight.w400 : FontWeight.w500,
      color: const Color(0xFF94A3B8),
      height: isTextArea ? 1.5 : 1.28,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(label, style: labelStyle),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: showAccentBorder
                  ? const Color(0xFFFA8075)
                  : Colors.transparent,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            initialValue: initialValue.isEmpty ? null : initialValue,
            onChanged: onChanged,
            minLines: isTextArea ? 4 : 1,
            maxLines: isTextArea ? 5 : 1,
            style: textStyle,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(
                21,
                isTextArea ? 21 : 20.5,
                21,
                isTextArea ? 21 : 20.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
