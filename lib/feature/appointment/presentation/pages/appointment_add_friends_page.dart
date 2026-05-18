import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/appointment_feed.dart';

class AppointmentAddFriendsPage extends StatefulWidget {
  final List<AppointmentInvitee> initialInvitees;

  const AppointmentAddFriendsPage({super.key, required this.initialInvitees});

  @override
  State<AppointmentAddFriendsPage> createState() =>
      _AppointmentAddFriendsPageState();
}

class _AppointmentAddFriendsPageState extends State<AppointmentAddFriendsPage> {
  late final TextEditingController _searchController;
  late List<AppointmentInvitee> _invitees;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _invitees = widget.initialInvitees
        .map(
          (invitee) => invitee.copyWith(
            isMuted: !invitee.isSelected,
            showRemoveBadge: invitee.id == 'sarah_jenkins',
          ),
        )
        .toList(growable: true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleInvitees = _invitees
        .where(_matchesSearch)
        .toList(growable: false);
    final suggested = visibleInvitees.take(2).toList(growable: false);
    final allFriends = visibleInvitees.skip(2).toList(growable: false);
    final selectedCount = _invitees
        .where((invitee) => invitee.isSelected)
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F5),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: <Widget>[
                  _CircleIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Text(
                      'Add Friends',
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: <Widget>[
                  Container(
                    height: 49,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF94A3B8),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value.trim().toLowerCase();
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search registered users...',
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2D2D2D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  if (visibleInvitees.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No registered users match your search.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF9E8F8A),
                        ),
                      ),
                    )
                  else ...<Widget>[
                    _SectionTitle(title: 'Suggested'),
                    const SizedBox(height: 12),
                    ...suggested.map(_buildFriendCard),
                    if (allFriends.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 20),
                      _SectionTitle(title: 'All Registered Users'),
                      const SizedBox(height: 12),
                      ...allFriends.map(_buildFriendCard),
                    ],
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
              child: _PrimaryFooterButton(
                label: 'Confirm Selection ($selectedCount)',
                onTap: () {
                  Navigator.of(context).pop(
                    _invitees
                        .map(
                          (invitee) =>
                              invitee.copyWith(isMuted: !invitee.isSelected),
                        )
                        .toList(growable: false),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendCard(AppointmentInvitee invitee) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _toggle(invitee.id),
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                _FriendAvatar(invitee: invitee),
                const SizedBox(width: 14),
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
                      const SizedBox(height: 2),
                      Text(
                        invitee.subtitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: invitee.id == 'sarah_jenkins'
                              ? const Color(0xFFFF6B5A)
                              : const Color(0xFF9E8F8A),
                        ),
                      ),
                    ],
                  ),
                ),
                _FriendSelectionIndicator(isSelected: invitee.isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggle(String inviteeId) {
    setState(() {
      _invitees = _invitees
          .map(
            (invitee) => invitee.id == inviteeId
                ? invitee.copyWith(
                    isSelected: !invitee.isSelected,
                    isMuted: invitee.isSelected,
                  )
                : invitee,
          )
          .toList(growable: false);
    });
  }

  bool _matchesSearch(AppointmentInvitee invitee) {
    if (_searchQuery.isEmpty) {
      return true;
    }

    final haystack = '${invitee.name} ${invitee.subtitle}'.toLowerCase();
    return haystack.contains(_searchQuery);
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF2D2D2D),
      ),
    );
  }
}

class _FriendAvatar extends StatelessWidget {
  final AppointmentInvitee invitee;

  const _FriendAvatar({required this.invitee});

  @override
  Widget build(BuildContext context) {
    if (!invitee.hasAvatar) {
      final initials = invitee.name
          .split(' ')
          .where((part) => part.isNotEmpty)
          .take(2)
          .map((part) => part[0])
          .join();

      final backgroundColor = invitee.id == 'alex_lee'
          ? const Color(0xFFE0ECFF)
          : const Color(0xFFEEDDFF);
      final foregroundColor = invitee.id == 'alex_lee'
          ? const Color(0xFF3C6FE8)
          : const Color(0xFF8C35D9);

      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: foregroundColor,
          ),
        ),
      );
    }

    return ClipOval(
      child: invitee.usesNetworkAvatar
          ? Image.network(
              invitee.avatarAssetPath,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            )
          : Image.asset(
              invitee.avatarAssetPath,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
    );
  }
}

class _FriendSelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const _FriendSelectionIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF6B5A) : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? const Color(0xFFFF6B5A) : const Color(0xFFC7B39D),
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
          : null,
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 22, color: const Color(0xFF2D2D2D)),
        ),
      ),
    );
  }
}

class _PrimaryFooterButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryFooterButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFF6B5A),
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x26FF6B5A),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
