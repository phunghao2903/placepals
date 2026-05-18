import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/appointment_feed.dart';
import '../../domain/entities/appointment_place_suggestion.dart';
import 'appointment_group_voting_page.dart';

class AppointmentSuggestPlacePage extends StatefulWidget {
  final String? appointmentId;
  final String title;
  final String dateLabel;
  final String timeLabel;
  final List<AppointmentInvitee> invitees;
  final List<AppointmentPlaceSuggestion>? initialPlaces;
  final bool replaceWithVotingOnReview;

  const AppointmentSuggestPlacePage({
    super.key,
    this.appointmentId,
    required this.title,
    required this.dateLabel,
    required this.timeLabel,
    required this.invitees,
    this.initialPlaces,
    this.replaceWithVotingOnReview = false,
  });

  @override
  State<AppointmentSuggestPlacePage> createState() =>
      _AppointmentSuggestPlacePageState();
}

class _AppointmentSuggestPlacePageState
    extends State<AppointmentSuggestPlacePage> {
  late List<AppointmentPlaceSuggestion> _places;

  @override
  void initState() {
    super.initState();
    _places = (widget.initialPlaces ?? _seedPlaces)
        .map((place) => place.copyWith())
        .toList(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _places.where((place) => place.isSelected).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F5),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F6F5),
                border: Border(bottom: BorderSide(color: Color(0xFFF1E7E2))),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _BackButton(onTap: () => Navigator.of(context).pop()),
                      Expanded(
                        child: Text(
                          'Suggest a Place',
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
                  const SizedBox(height: 20),
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
                          color: Color(0xFFD0C2BB),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Search for restaurant, cafe...',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFD0C2BB),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Nearby & Recent',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2D2D2D),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'View Map',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF6B5A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ..._places.map(_buildPlaceCard),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: _BottomCta(
                label: 'Review Suggestions',
                count: selectedCount,
                onTap: _openGroupVoting,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard(AppointmentPlaceSuggestion place) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _toggle(place.id),
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: place.isSelected
                  ? Border.all(color: const Color(0x33FF6B5A))
                  : null,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    place.imageAssetPath,
                    width: 80,
                    height: 80,
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
                          fontSize: 18,
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
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.star_rounded,
                            size: 15,
                            color: Color(0xFFF4B23E),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${place.rating.toStringAsFixed(1)} (${place.reviewsCount})',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6D625D),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _SelectionCircle(isSelected: place.isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggle(String placeId) {
    setState(() {
      _places = _places
          .map(
            (place) => place.id == placeId
                ? place.copyWith(isSelected: !place.isSelected)
                : place,
          )
          .toList(growable: false);
    });
  }

  void _openGroupVoting() {
    final route = MaterialPageRoute<void>(
      builder: (_) => AppointmentGroupVotingPage(
        places: _places,
        title: widget.title,
        dateLabel: widget.dateLabel,
        timeLabel: widget.timeLabel,
        invitees: widget.invitees,
      ),
    );

    if (widget.replaceWithVotingOnReview) {
      Navigator.of(context).pushReplacement(route);
      return;
    }

    Navigator.of(context).push(route);
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 22,
          color: Color(0xFF2D2D2D),
        ),
      ),
    );
  }
}

class _SelectionCircle extends StatelessWidget {
  final bool isSelected;

  const _SelectionCircle({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF6B5A) : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFFF6B5A)),
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, color: Colors.white)
          : const Icon(Icons.add_rounded, color: Color(0xFFFF6B5A)),
    );
  }
}

class _BottomCta extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onTap;

  const _BottomCta({
    required this.label,
    required this.count,
    required this.onTap,
  });

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
          padding: const EdgeInsets.symmetric(horizontal: 22),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$count',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<AppointmentPlaceSuggestion> _seedPlaces =
    <AppointmentPlaceSuggestion>[
      AppointmentPlaceSuggestion(
        id: 'salmon',
        name: 'Salmon Sushi Bar',
        cuisine: 'Japanese',
        priceLabel: '\$\$',
        distanceLabel: '0.2 mi',
        rating: 4.8,
        reviewsCount: 128,
        imageAssetPath: 'assets/images/cafe_tan.png',
        status: AppointmentPlaceStatus.open,
        statusLabel: 'Open until 10 PM',
        socialProofLabel: 'You and 3 others',
        voteProgress: 0.78,
        isSelected: false,
        isTopChoice: true,
        isHighlighted: false,
      ),
      AppointmentPlaceSuggestion(
        id: 'rustic',
        name: 'The Rustic Table',
        cuisine: 'American',
        priceLabel: '\$\$\$',
        distanceLabel: '1.4 mi',
        rating: 4.5,
        reviewsCount: 84,
        imageAssetPath: 'assets/images/bean_bloom.png',
        status: AppointmentPlaceStatus.closingSoon,
        statusLabel: 'Closes soon (9 PM)',
        socialProofLabel: 'Mike voted for this',
        voteProgress: 0.24,
        isSelected: true,
        isTopChoice: false,
        isHighlighted: false,
      ),
      AppointmentPlaceSuggestion(
        id: 'luigi',
        name: 'Luigi\'s Trattoria',
        cuisine: 'Italian',
        priceLabel: '\$\$',
        distanceLabel: '0.8 mi',
        rating: 4.9,
        reviewsCount: 312,
        imageAssetPath: 'assets/images/korea_food.jpeg',
        status: AppointmentPlaceStatus.open,
        statusLabel: 'Open until 11 PM',
        socialProofLabel: 'Sarah and 1 other',
        voteProgress: 0.52,
        isSelected: false,
        isTopChoice: false,
        isHighlighted: false,
      ),
      AppointmentPlaceSuggestion(
        id: 'pizza',
        name: 'Pizza Heaven',
        cuisine: 'Pizza',
        priceLabel: '\$',
        distanceLabel: '3.2 mi',
        rating: 4.2,
        reviewsCount: 56,
        imageAssetPath: 'assets/images/profile.jpg',
        status: AppointmentPlaceStatus.open,
        statusLabel: 'Open until 2 AM',
        socialProofLabel: 'Be the first to vote for this',
        voteProgress: 0.0,
        isSelected: false,
        isTopChoice: false,
        isHighlighted: false,
      ),
    ];
