import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/appointment_feed.dart';
import 'appointment_add_friends_page.dart';
import 'appointment_select_when_page.dart';

class AppointmentEditResult {
  final String dateLabel;
  final String timeLabel;
  final List<AppointmentInvitee> invitees;

  const AppointmentEditResult({
    required this.dateLabel,
    required this.timeLabel,
    required this.invitees,
  });
}

class AppointmentEditHangoutPage extends StatefulWidget {
  final String dateLabel;
  final String timeLabel;
  final List<AppointmentInvitee> invitees;

  const AppointmentEditHangoutPage({
    super.key,
    required this.dateLabel,
    required this.timeLabel,
    required this.invitees,
  });

  @override
  State<AppointmentEditHangoutPage> createState() =>
      _AppointmentEditHangoutPageState();
}

class _AppointmentEditHangoutPageState
    extends State<AppointmentEditHangoutPage> {
  late String _dateLabel;
  late String _timeLabel;
  late List<AppointmentInvitee> _invitees;

  @override
  void initState() {
    super.initState();
    _dateLabel = widget.dateLabel;
    _timeLabel = widget.timeLabel;
    _invitees = widget.invitees;
  }

  @override
  Widget build(BuildContext context) {
    final visibleInvitees = _invitees
        .where((invitee) => invitee.isSelected)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F5),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          children: <Widget>[
            Row(
              children: <Widget>[
                _HeaderButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Text(
                    'Edit Hangout',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(
                      AppointmentEditResult(
                        dateLabel: _dateLabel,
                        timeLabel: _timeLabel,
                        invitees: _invitees,
                      ),
                    );
                  },
                  child: Text(
                    'Save',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFF6B5A),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            _InfoCard(
              icon: Icons.access_time_rounded,
              title: 'Time',
              value: _timeLabel,
              onTap: _openWhenPicker,
            ),
            const SizedBox(height: 16),
            _InfoCard(
              icon: Icons.calendar_today_outlined,
              title: 'Date',
              value: _dateLabel,
              onTap: _openWhenPicker,
            ),
            const SizedBox(height: 28),
            Text(
              'Attendees',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: <Widget>[
                  _AttendeeTile(
                    invitee: const AppointmentInvitee(
                      id: 'you',
                      name: 'You',
                      subtitle: 'Host',
                      avatarAssetPath: '',
                      isSelected: true,
                      isMuted: false,
                      showRemoveBadge: false,
                    ),
                    isHost: true,
                  ),
                  ...visibleInvitees.map(
                    (invitee) => _AttendeeTile(
                      invitee: invitee,
                      onRemove: () {
                        setState(() {
                          _invitees = _invitees
                              .map(
                                (item) => item.id == invitee.id
                                    ? item.copyWith(
                                        isSelected: false,
                                        isMuted: true,
                                      )
                                    : item,
                              )
                              .toList(growable: false);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: _openAddFriends,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                side: const BorderSide(
                  color: Color(0x80FF6B5A),
                  style: BorderStyle.solid,
                ),
              ),
              icon: const Icon(
                Icons.person_add_alt_1_rounded,
                color: Color(0xFFFF6B5A),
              ),
              label: Text(
                'Add Friends',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFF6B5A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openWhenPicker() async {
    final result = await Navigator.of(context)
        .push<AppointmentWhenSelectionResult>(
          MaterialPageRoute<AppointmentWhenSelectionResult>(
            builder: (_) => AppointmentSelectWhenPage(
              initialDateLabel: _dateLabel,
              initialTimeLabel: _timeLabel,
            ),
          ),
        );

    if (result == null || !mounted) return;

    setState(() {
      _dateLabel = result.dateLabel;
      _timeLabel = result.timeLabel;
    });
  }

  Future<void> _openAddFriends() async {
    final result = await Navigator.of(context).push<List<AppointmentInvitee>>(
      MaterialPageRoute<List<AppointmentInvitee>>(
        builder: (_) => AppointmentAddFriendsPage(initialInvitees: _invitees),
      ),
    );

    if (result == null || !mounted) return;

    setState(() {
      _invitees = result;
    });
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x1AFA8075),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0x1AFA8075),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFFFF6B5A)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9E8F8A),
                      ),
                    ),
                    Text(
                      value,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D2D2D),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF8A817C)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttendeeTile extends StatelessWidget {
  final AppointmentInvitee invitee;
  final bool isHost;
  final VoidCallback? onRemove;

  const _AttendeeTile({
    required this.invitee,
    this.isHost = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = isHost
        ? 'Host'
        : (invitee.id == 'marcus_chen' ? 'Pending' : 'Accepted');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1E7E2))),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: invitee.hasAvatar
                ? (invitee.usesNetworkAvatar
                          ? NetworkImage(invitee.avatarAssetPath)
                          : AssetImage(invitee.avatarAssetPath))
                      as ImageProvider
                : null,
            child: !invitee.hasAvatar
                ? Text(invitee.name.characters.first)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  invitee.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: subtitle == 'Host'
                        ? const Color(0xFFFF6B5A)
                        : const Color(0xFF9E8F8A),
                  ),
                ),
              ],
            ),
          ),
          if (!isHost)
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.remove_circle_outline_rounded),
              color: const Color(0xFF8A817C),
            ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icon, size: 22, color: const Color(0xFF2D2D2D)),
      ),
    );
  }
}
