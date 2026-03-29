import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/appointment_feed.dart';
import '../../domain/entities/appointment_place_suggestion.dart';
import 'appointment_chat_page.dart';
import 'appointment_edit_hangout_page.dart';
import 'appointment_plan_confirmed_page.dart';
import 'appointment_suggest_place_page.dart';

class AppointmentGroupVotingPage extends StatefulWidget {
  final List<AppointmentPlaceSuggestion> places;
  final String title;
  final String dateLabel;
  final String timeLabel;
  final List<AppointmentInvitee> invitees;

  const AppointmentGroupVotingPage({
    super.key,
    required this.places,
    this.title = 'Saturday Dinner',
    this.dateLabel = 'Sat, Mar 7',
    this.timeLabel = '19:00',
    this.invitees = const <AppointmentInvitee>[],
  });

  @override
  State<AppointmentGroupVotingPage> createState() =>
      _AppointmentGroupVotingPageState();
}

class _AppointmentGroupVotingPageState extends State<AppointmentGroupVotingPage> {
  late List<AppointmentPlaceSuggestion> _places;
  late String _dateLabel;
  late String _timeLabel;
  late List<AppointmentInvitee> _invitees;
  late DateTime _voteEndsAt;
  Timer? _voteTimer;
  bool _hasNavigatedToFinal = false;

  @override
  void initState() {
    super.initState();
    final initiallySelectedIds = widget.places
        .where((place) => place.isSelected)
        .map((place) => place.id)
        .toSet();
    final highlightedId = initiallySelectedIds.isNotEmpty
        ? widget.places.firstWhere((place) => place.isSelected).id
        : widget.places
            .firstWhere(
              (place) => place.name == 'Salmon Sushi Bar',
              orElse: () => widget.places.first,
            )
            .id;

    _places = widget.places
        .map(
          (place) => place.copyWith(
            isHighlighted: place.id == highlightedId,
            isSelected: initiallySelectedIds.isEmpty
                ? place.id == highlightedId
                : initiallySelectedIds.contains(place.id),
          ),
        )
        .toList(growable: true);
    _dateLabel = widget.dateLabel;
    _timeLabel = widget.timeLabel;
    _invitees = widget.invitees;
    _voteEndsAt = DateTime.now().add(const Duration(hours: 2));
    _voteTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      if (_remainingVoteTime <= Duration.zero) {
        _voteTimer?.cancel();
        _openPlanFinalDecision(replaceCurrentPage: true);
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _voteTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F5),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                children: <Widget>[
                  Row(
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
                          widget.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D2D2D),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _openEditHangout,
                        child: Text(
                          'Edit',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFF6B5A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 33,
                    decoration: BoxDecoration(
                      color: const Color(0x1AFF6B5A),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 18,
                          color: Color(0xFFFF6B5A),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _voteBannerLabel,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFF6B5A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 140),
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  final place = _places[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _VotingCard(
                      place: place,
                      onTap: () => _select(place.id),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _openChat(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        side: const BorderSide(color: Color(0xFFFF6B5A)),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                      label: Text(
                        'Chat',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF6B5A),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _openSuggestPlace,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        backgroundColor: const Color(0xFFFF6B5A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Text(
                        'Add Place',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
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

  void _select(String placeId) {
    setState(() {
      _places = _places
          .map(
            (place) => place.copyWith(
              isSelected: place.id == placeId,
              isHighlighted: place.id == placeId,
            ),
          )
          .toList(growable: false);
    });
  }

  AppointmentPlaceSuggestion get _selectedPlace {
    return _places.firstWhere(
      (place) => place.isSelected,
      orElse: () => _places.first,
    );
  }

  void _openChat(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AppointmentChatPage(
          invitees: _invitees,
          placeName: _selectedPlace.name,
        ),
      ),
    );
  }

  Duration get _remainingVoteTime => _voteEndsAt.difference(DateTime.now());

  String get _voteBannerLabel {
    final remaining = _remainingVoteTime;
    if (remaining <= Duration.zero) {
      return 'Voting has ended';
    }

    final hours = remaining.inHours;
    final minutes = remaining.inMinutes.remainder(60);

    if (hours > 0) {
      return minutes == 0
          ? 'Voting ends in $hours hour${hours == 1 ? '' : 's'}'
          : 'Voting ends in ${hours}h ${minutes}m';
    }

    return 'Voting ends in ${minutes.clamp(1, 59)} min';
  }

  void _openSuggestPlace() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => AppointmentSuggestPlacePage(
          title: widget.title,
          dateLabel: _dateLabel,
          timeLabel: _timeLabel,
          invitees: _invitees,
          initialPlaces: _places,
          replaceWithVotingOnReview: true,
        ),
      ),
    );
  }

  void _openPlanFinalDecision({bool replaceCurrentPage = false}) {
    if (_hasNavigatedToFinal || !mounted) return;
    _hasNavigatedToFinal = true;

    final route = MaterialPageRoute<void>(
      builder: (_) => AppointmentPlanConfirmedPage(
        selectedPlace: _selectedPlace,
        dateLabel: _dateLabel,
        timeLabel: _timeLabel,
        invitees: _invitees,
      ),
    );

    if (replaceCurrentPage) {
      Navigator.of(context).pushReplacement(route);
      return;
    }

    Navigator.of(context).push(route);
  }

  Future<void> _openEditHangout() async {
    final result = await Navigator.of(context).push<AppointmentEditResult>(
      MaterialPageRoute<AppointmentEditResult>(
        builder: (_) => AppointmentEditHangoutPage(
          dateLabel: _dateLabel,
          timeLabel: _timeLabel,
          invitees: _invitees,
        ),
      ),
    );

    if (result == null || !mounted) return;

    setState(() {
      _dateLabel = result.dateLabel;
      _timeLabel = result.timeLabel;
      _invitees = result.invitees;
    });
  }
}

class _VotingCard extends StatelessWidget {
  final AppointmentPlaceSuggestion place;
  final VoidCallback onTap;

  const _VotingCard({
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (place.status) {
      AppointmentPlaceStatus.open => const Color(0xFF18B663),
      AppointmentPlaceStatus.closingSoon => const Color(0xFFB1A49D),
      AppointmentPlaceStatus.unknown => const Color(0xFFB1A49D),
    };

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: place.isHighlighted
                ? Border.all(color: const Color(0xFFFF6B5A), width: 1.5)
                : Border.all(color: const Color(0xFFEFE7E2)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(44),
                        child: Image.asset(
                          place.imageAssetPath,
                          width: 88,
                          height: 88,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              place.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2D2D2D),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${place.cuisine} • ${place.priceLabel} • ${place.distanceLabel}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF9E8F8A),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: <Widget>[
                                Icon(
                                  place.status == AppointmentPlaceStatus.closingSoon
                                      ? Icons.access_time_rounded
                                      : Icons.access_time_rounded,
                                  size: 14,
                                  color: statusColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  place.statusLabel,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: Color(0xFFEFE7E2)),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          place.socialProofLabel,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFB1A49D),
                          ),
                        ),
                      ),
                      Container(
                        width: 64,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0E6E2),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: place.voteProgress.clamp(0, 1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: place.isHighlighted
                                    ? const Color(0xFFFF6B5A)
                                    : const Color(0xFFD0C2BB),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (place.isSelected)
                Positioned(
                  top: -9,
                  right: -9,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B5A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
