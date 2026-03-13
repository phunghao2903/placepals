import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/map_category.dart';
import '../../domain/entities/map_feed.dart';
import '../../domain/entities/map_marker.dart';
import '../bloc/map_bloc.dart';
import '../widgets/map_action_button.dart';
import '../widgets/map_category_chip.dart';
import '../widgets/map_friend_filter.dart';
import '../widgets/map_place_marker.dart';
import '../widgets/map_search_bar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (_) => getIt<MapBloc>()..add(const MapStarted()),
      child: const _MapView(),
    );
  }
}

class _MapView extends StatefulWidget {
  const _MapView();

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F3F2),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          switch (state.status) {
            case MapStatus.initial:
            case MapStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case MapStatus.failure:
              return Center(
                child: Text(
                  state.errorMessage ?? 'Something went wrong.',
                  style: AppTextStyles.body2,
                ),
              );
            case MapStatus.success:
              final feed = state.feed;
              if (feed == null) {
                return const SizedBox.shrink();
              }

              return _MapContent(
                feed: feed,
                controller: _searchController,
              );
          }
        },
      ),
    );
  }
}

class _MapContent extends StatelessWidget {
  final MapFeed feed;
  final TextEditingController controller;

  const _MapContent({
    required this.feed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.cover,
              ),
            ),
            _MapMarkerLayer(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              markers: feed.markers,
            ),
            Positioned(
              right: 15,
              top: constraints.maxHeight * (215 / 844),
              child: const MapActionButton(icon: Icons.gps_fixed_rounded),
            ),
            Positioned(
              right: 15,
              top: constraints.maxHeight * (275 / 844),
              child: const MapActionButton(icon: Icons.layers_outlined),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MapSearchBar(
                      controller: controller,
                      hintText: feed.searchHint,
                      onChanged: (query) {
                        context.read<MapBloc>().add(
                              MapSearchChanged(query: query),
                            );
                      },
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Container(
                        width: 238,
                        height: 44,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          children: feed.friendFilters
                              .map(
                                (filter) => Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: filter == feed.friendFilters.first
                                          ? 0
                                          : 8,
                                    ),
                                    child: MapFriendFilter(
                                      label: filter.label,
                                      isSelected: filter.isSelected,
                                      onTap: () {
                                        context.read<MapBloc>().add(
                                              MapFriendFilterSelected(
                                                filterId: filter.id,
                                              ),
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              )
                              .toList(growable: false),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      height: 35,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: feed.categories.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          final MapCategory category = feed.categories[index];
                          return MapCategoryChip(
                            label: category.label,
                            iconAsset: category.iconAsset,
                            isSelected: category.isSelected,
                            onTap: () {
                              context.read<MapBloc>().add(
                                    MapCategorySelected(
                                      categoryId: category.id,
                                    ),
                                  );
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
    );
  }
}

class _MapMarkerLayer extends StatelessWidget {
  final double width;
  final double height;
  final List<MapMarker> markers;

  const _MapMarkerLayer({
    required this.width,
    required this.height,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
    final markerChildren = <Widget>[];

    for (final marker in markers) {
      if (marker.avatarLeftRatio != null && marker.avatarTopRatio != null) {
        markerChildren.add(
          Positioned(
            left: width * marker.avatarLeftRatio!,
            top: height * marker.avatarTopRatio!,
            child: _FriendAvatar(
              size: 30,
              tintHex: marker.avatarTintHex,
            ),
          ),
        );
      }

      if (marker.showMarker) {
        markerChildren.add(
          Positioned(
            left: width * marker.markerLeftRatio,
            top: height * marker.markerTopRatio,
            child: MapPlaceMarker(rating: marker.rating),
          ),
        );
      }
    }

    return Stack(
      children: markerChildren,
    );
  }
}

class _FriendAvatar extends StatelessWidget {
  final double size;
  final int? tintHex;

  const _FriendAvatar({
    required this.size,
    this.tintHex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.surface,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: ColorFiltered(
          colorFilter: tintHex == null
              ? const ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.dst,
                )
              : ColorFilter.mode(
                  Color(tintHex!).withOpacity(0.28),
                  BlendMode.srcATop,
                ),
          child: Image.asset(
            'assets/images/profile.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
