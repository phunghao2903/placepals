import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_place.dart';
import '../bloc/create_moment_bloc.dart';
import '../widgets/create_moment_location_tile.dart';

class CreateMomentLocationPage extends StatefulWidget {
  const CreateMomentLocationPage({super.key});

  @override
  State<CreateMomentLocationPage> createState() =>
      _CreateMomentLocationPageState();
}

class _CreateMomentLocationPageState extends State<CreateMomentLocationPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: context.read<CreateMomentBloc>().state.locationQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F0),
      body: SafeArea(
        child: BlocBuilder<CreateMomentBloc, CreateMomentState>(
          builder: (context, state) {
            final feed = state.feed;
            if (feed == null) return const SizedBox.shrink();

            final places = _filterPlaces(
              feed.nearbyPlaces,
              state.locationQuery,
            );

            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.textPrimary,
                                  size: 20,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                feed.locationTitle,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _LocationSearchField(
                        controller: _searchController,
                        hintText: feed.locationSearchHint,
                        onChanged: (value) {
                          context.read<CreateMomentBloc>().add(
                            CreateMomentLocationQueryChanged(query: value),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: _MapPreviewCard(
                    ctaLabel: feed.pickOnMapLabel,
                    onTap: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Map picker is not connected yet.'),
                          ),
                        );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFCFAFA),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 40,
                          offset: Offset(0, -10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Container(
                          width: 48,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 12),
                          child: Row(
                            children: <Widget>[
                              Text(
                                feed.nearbyPlacesTitle,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<CreateMomentBloc>().add(
                                    const CreateMomentLocationQueryChanged(
                                      query: '',
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.refresh_rounded,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                            itemCount: places.length,
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final place = places[index];
                              return CreateMomentLocationTile(
                                place: place,
                                isSelected:
                                    state.selectedLocationId == place.id,
                                onTap: () {
                                  context.read<CreateMomentBloc>().add(
                                    CreateMomentLocationSelected(
                                      placeId: place.id,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<CreateMomentPlace> _filterPlaces(
    List<CreateMomentPlace> places,
    String query,
  ) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return places;

    return places
        .where((place) {
          return place.title.toLowerCase().contains(normalized) ||
              place.subtitle.toLowerCase().contains(normalized);
        })
        .toList(growable: false);
  }
}

class _LocationSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  const _LocationSearchField({
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class _MapPreviewCard extends StatelessWidget {
  final String ctaLabel;
  final VoidCallback onTap;

  const _MapPreviewCard({required this.ctaLabel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      decoration: BoxDecoration(
        color: const Color(0xFFEFEAE9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.white.withValues(alpha: 0.4),
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          const Center(
            child: Icon(
              Icons.location_on_rounded,
              size: 48,
              color: AppColors.primary,
              shadows: <Shadow>[
                Shadow(
                  color: Color(0x1A000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
          Positioned(
            left: 97,
            right: 97,
            bottom: 16,
            child: FilledButton.icon(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(
                Icons.map_outlined,
                color: AppColors.primary,
                size: 18,
              ),
              label: Text(
                ctaLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
