import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../map/presentation/pages/map_page.dart';
import '../../domain/entities/appointment_feed.dart';
import '../../domain/entities/appointment_place_suggestion.dart';
import 'appointment_chat_page.dart';

class AppointmentPlanConfirmedPage extends StatelessWidget {
  final AppointmentPlaceSuggestion selectedPlace;
  final String dateLabel;
  final String timeLabel;
  final List<AppointmentInvitee> invitees;

  const AppointmentPlanConfirmedPage({
    super.key,
    required this.selectedPlace,
    required this.dateLabel,
    required this.timeLabel,
    required this.invitees,
  });

  @override
  Widget build(BuildContext context) {
    final attending = invitees.where((invitee) => invitee.isSelected).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: <Widget>[
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => Navigator.of(context).pop(),
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Plan Confirmed',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: <Widget>[
                  Text(
                    'It\'s a Date! 🎉',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1B2340),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Everyone has voted. Here\'s the plan.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB1A49D),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: const Color(0x33FF6B5A)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                selectedPlace.imageAssetPath,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B5A),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  'Top Choice',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                selectedPlace.name,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2D2D2D),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${selectedPlace.cuisine} • ${selectedPlace.priceLabel} • ${selectedPlace.rating.toStringAsFixed(1)} ★',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFFF6B5A),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(46),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                        side: const BorderSide(
                                          color: Color(0x55FF6B5A),
                                        ),
                                      ),
                                      child: Text(
                                        'View Menu',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFFF6B5A),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Call',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF25304F),
                                        ),
                                      ),
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
                  const SizedBox(height: 20),
                  _InfoSummaryCard(dateLabel: dateLabel, timeLabel: timeLabel),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Text(
                        '${attending.length + 1} Going',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D2D2D),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F1F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'All Confirmed',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFB1A49D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: <Widget>[
                        ...attending
                            .take(4)
                            .map(
                              (invitee) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage: invitee.hasAvatar
                                      ? (invitee.usesNetworkAvatar
                                                ? NetworkImage(
                                                    invitee.avatarAssetPath,
                                                  )
                                                : AssetImage(
                                                    invitee.avatarAssetPath,
                                                  ))
                                            as ImageProvider
                                      : null,
                                  child: !invitee.hasAvatar
                                      ? Text(invitee.name.characters.first)
                                      : null,
                                ),
                              ),
                            ),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF7F3F1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: Color(0xFFB1A49D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => AppointmentChatPage(
                              invitees: invitees,
                              placeName: selectedPlace.name,
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        side: const BorderSide(color: Color(0xFFFF6B5A)),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                      label: Text(
                        'Chat',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF6B5A),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const MapPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(54),
                        backgroundColor: const Color(0xFFFF6B5A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                      icon: const Icon(
                        Icons.directions_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Get Directions',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSummaryCard extends StatelessWidget {
  final String dateLabel;
  final String timeLabel;

  const _InfoSummaryCard({required this.dateLabel, required this.timeLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0x33FF6B5A)),
      ),
      child: Column(
        children: <Widget>[
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            title: 'When',
            value: dateLabel,
          ),
          const Divider(height: 1, color: Color(0x33FF6B5A)),
          _InfoRow(
            icon: Icons.access_time_rounded,
            title: 'Time',
            value: timeLabel,
          ),
          const Divider(height: 1, color: Color(0x33FF6B5A)),
          const _InfoRow(
            icon: Icons.location_on_outlined,
            title: 'Where',
            value: '123 Fresh St, Seattle, WA',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0x1AFA8075),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFFFF6B5A)),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFF6B5A),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
