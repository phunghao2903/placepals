import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/location_option.dart';
import '../bloc/location_bloc.dart';
import '../widgets/location_destination_card.dart';

class LocationPage extends StatelessWidget {
  final String currentCity;

  const LocationPage({super.key, required this.currentCity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
      create: (_) => getIt<LocationBloc>()
        ..add(LocationStarted(initialLocationId: _normalizeLocationId(currentCity))),
      child: _LocationView(currentCity: currentCity),
    );
  }

  static String _normalizeLocationId(String city) {
    final normalized = city.trim().toLowerCase().replaceAll(' ', '-');
    switch (normalized) {
      case 'ho-chi-minh':
        return 'ho-chi-minh-city';
      default:
        return normalized;
    }
  }
}

class _LocationView extends StatefulWidget {
  final String currentCity;

  const _LocationView({required this.currentCity});

  @override
  State<_LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<_LocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            switch (state.status) {
              case LocationStatus.initial:
              case LocationStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case LocationStatus.failure:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Unable to load locations.',
                    style: AppTextStyles.body2,
                  ),
                );
              case LocationStatus.success:
                final feed = state.feed;
                if (feed == null) {
                  return const SizedBox.shrink();
                }

                final locations = state.filteredLocations;
                LocationOption? selectedLocation;
                for (final location in locations) {
                  if (location.id == state.selectedLocationId) {
                    selectedLocation = location;
                    break;
                  }
                }
                final selectedLocationTitle = selectedLocation?.title;

                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          feed.title,
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: const Color(0xFFF0E9E8)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        feed.popularSectionTitle,
                                        style: AppTextStyles.heading4.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Select a destination to find your PlacePal',
                                        style: AppTextStyles.body2,
                                      ),
                                      const SizedBox(height: 16),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: locations.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 16,
                                              crossAxisSpacing: 14,
                                              childAspectRatio: 0.86,
                                            ),
                                        itemBuilder: (context, index) {
                                          final location = locations[index];
                                          return LocationDestinationCard(
                                            location: location,
                                            isSelected:
                                                state.selectedLocationId ==
                                                location.id,
                                            onTap: () => _selectLocation(
                                              context,
                                              location,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.fromLTRB(12, 18, 12, 14),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Color(0xFFF0E9E8)),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 48,
                                  child: FilledButton(
                                    onPressed: selectedLocationTitle == null
                                        ? null
                                        : () {
                                            Navigator.of(
                                              context,
                                            ).pop(selectedLocationTitle);
                                          },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      disabledBackgroundColor:
                                          AppColors.textSecondary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Saved',
                                      style: AppTextStyles.heading6.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  void _selectLocation(BuildContext context, LocationOption location) {
    context.read<LocationBloc>().add(LocationSelected(locationId: location.id));
  }
}
