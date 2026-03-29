import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/appointment_feed.dart';

class AppointmentInviteButton extends StatelessWidget {
  final VoidCallback onTap;

  const AppointmentInviteButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: SizedBox(
            width: 72,
            child: Column(
              children: <Widget>[
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0x0DFA8075),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0x66FA8075),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                      size: 28,
                      color: Color(0xFFFA8075),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Invite',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFFA8075),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentInviteeAvatar extends StatelessWidget {
  final AppointmentInvitee invitee;
  final VoidCallback onTap;

  const AppointmentInviteeAvatar({
    super.key,
    required this.invitee,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = invitee.isSelected;
    final hasAvatar = invitee.avatarAssetPath.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Opacity(
        opacity: invitee.isMuted ? 0.6 : 1,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: onTap,
            child: SizedBox(
              width: 72,
              child: Column(
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: hasAvatar
                            ? Image.asset(
                                invitee.avatarAssetPath,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: invitee.id == 'alex_lee'
                                    ? const Color(0xFFE0ECFF)
                                    : const Color(0xFFEEDDFF),
                                alignment: Alignment.center,
                                child: Text(
                                  invitee.name
                                      .split(' ')
                                      .where((part) => part.isNotEmpty)
                                      .take(2)
                                      .map((part) => part[0])
                                      .join(),
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: invitee.id == 'alex_lee'
                                        ? const Color(0xFF3C6FE8)
                                        : const Color(0xFF8C35D9),
                                  ),
                                ),
                              ),
                      ),
                      if (invitee.showRemoveBadge && isSelected)
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFA8075),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFF8F6F5),
                                width: 2,
                              ),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    invitee.name,
                    style: isSelected
                        ? GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF2D2D2D),
                          )
                        : GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF334155),
                            height: 1.43,
                          ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
