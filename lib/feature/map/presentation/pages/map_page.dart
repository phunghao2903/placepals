import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/map_category.dart';
import '../../domain/entities/map_feed.dart';
import '../../domain/entities/map_marker.dart';
import '../../domain/entities/map_style_option.dart';
import '../bloc/map_bloc.dart';
import '../widgets/map_action_button.dart';
import '../widgets/map_category_chip.dart';
import '../widgets/map_friend_filter.dart';
import '../widgets/map_layer_sheet.dart';
import '../widgets/map_place_marker.dart';
import '../widgets/map_place_preview_card.dart';
import '../widgets/map_search_bar.dart';
import 'map_location_page.dart';
import 'map_place_detail_page.dart';

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
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<MapBloc, MapState>(
          listenWhen: (previous, current) => previous.query != current.query,
          listener: (context, state) {
            if (_searchController.text != state.query) {
              _searchController.value = TextEditingValue(
                text: state.query,
                selection: TextSelection.collapsed(offset: state.query.length),
              );
            }
          },
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

                if (_searchController.text != state.query) {
                  _searchController.value = TextEditingValue(
                    text: state.query,
                    selection: TextSelection.collapsed(
                      offset: state.query.length,
                    ),
                  );
                }

                return _MapContent(
                  feed: feed,
                  state: state,
                  controller: _searchController,
                );
            }
          },
        ),
      ),
    );
  }
}

class _MapContent extends StatelessWidget {
  final MapFeed feed;
  final MapState state;
  final TextEditingController controller;

  const _MapContent({
    required this.feed,
    required this.state,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final selectedStyle = feed.styleOptions.firstWhere(
      (item) => item.isSelected,
    );
    final bool showPreview = state.selectedMarkerId == 'marker-4-8';
    final double previewBottom = 104 + MediaQuery.paddingOf(context).bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            Positioned.fill(child: _MapBackground(style: selectedStyle.type)),
            _MapMarkerLayer(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              markers: feed.markers,
              selectedMarkerId: state.selectedMarkerId,
              showCurrentLocation: state.showCurrentLocation,
              onMarkerTap: (marker) {
                if (!marker.canSelectPreview) return;
                context.read<MapBloc>().add(
                  MapMarkerSelected(markerId: marker.id),
                );
              },
            ),
            Positioned(
              right: 15,
              top: constraints.maxHeight * (215 / 844),
              child: MapActionButton(
                icon: Icons.gps_fixed_rounded,
                onTap: () {
                  context.read<MapBloc>().add(
                    const MapCurrentLocationPressed(),
                  );
                },
              ),
            ),
            Positioned(
              right: 15,
              top: constraints.maxHeight * (275 / 844),
              child: MapActionButton(
                icon: Icons.layers_outlined,
                onTap: () {
                  context.read<MapBloc>().add(const MapLayerSheetOpened());
                },
              ),
            ),
            IgnorePointer(
              ignoring: state.isLayerSheetOpen,
              child: Opacity(
                opacity: state.isLayerSheetOpen ? 0.6 : 1,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MapSearchBar(
                          controller: controller,
                          hintText: feed.searchHint,
                          readOnly: true,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<MapBloc>(),
                                  child: const MapLocationPage(),
                                ),
                              ),
                            );
                          },
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              children: feed.friendFilters
                                  .map(
                                    (filter) => Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left:
                                              filter == feed.friendFilters.first
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
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 15),
                            itemBuilder: (context, index) {
                              final MapCategory category =
                                  feed.categories[index];
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
              ),
            ),
            if (showPreview && !state.isLayerSheetOpen)
              Positioned(
                left: 15,
                right: 15,
                bottom: previewBottom,
                child: MapPlacePreviewCard(
                  place: feed.previewPlace,
                  onSaveToggle: () {
                    context.read<MapBloc>().add(const MapPreviewSavedToggled());
                  },
                  onOpenDetail: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider.value(
                          value: context.read<MapBloc>(),
                          child: const MapPlaceDetailPage(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (state.isLayerSheetOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    context.read<MapBloc>().add(const MapLayerSheetClosed());
                  },
                  child: ColoredBox(
                    color: Colors.white.withValues(alpha: 0.40),
                  ),
                ),
              ),
            if (state.isLayerSheetOpen)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: MapLayerSheet(
                  styleOptions: feed.styleOptions,
                  overlaySettings: feed.overlaySettings,
                  onClose: () {
                    context.read<MapBloc>().add(const MapLayerSheetClosed());
                  },
                  onStyleSelected: (styleId) {
                    context.read<MapBloc>().add(
                      MapStyleSelected(styleId: styleId),
                    );
                  },
                  onOverlayToggled: (overlayId) {
                    context.read<MapBloc>().add(
                      MapOverlayToggled(overlayId: overlayId),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _MapBackground extends StatelessWidget {
  final MapStyleType style;

  const _MapBackground({required this.style});

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case MapStyleType.standard:
        return Image.asset('assets/images/map.png', fit: BoxFit.cover);
      case MapStyleType.satellite:
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            1.2,
            0,
            0,
            0,
            0,
            0,
            1.0,
            0,
            0,
            10,
            0,
            0,
            0.7,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: Image.asset('assets/images/map.png', fit: BoxFit.cover),
        );
      case MapStyleType.terrain:
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.8,
            0.1,
            0,
            0,
            30,
            0.1,
            0.8,
            0.1,
            0,
            25,
            0,
            0.1,
            0.7,
            0,
            10,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: Image.asset('assets/images/map.png', fit: BoxFit.cover),
        );
      case MapStyleType.nightMode:
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.15,
            0,
            0,
            0,
            0,
            0,
            0.18,
            0,
            0,
            0,
            0,
            0,
            0.35,
            0,
            20,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: Image.asset('assets/images/map.png', fit: BoxFit.cover),
        );
    }
  }
}

class _MapMarkerLayer extends StatelessWidget {
  final double width;
  final double height;
  final List<MapMarker> markers;
  final String selectedMarkerId;
  final bool showCurrentLocation;
  final ValueChanged<MapMarker> onMarkerTap;

  const _MapMarkerLayer({
    required this.width,
    required this.height,
    required this.markers,
    required this.selectedMarkerId,
    required this.showCurrentLocation,
    required this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    final markerChildren = <Widget>[];

    for (final marker in markers) {
      if (marker.avatarLeftRatio != null && marker.avatarTopRatio != null) {
        final bool isLargePlaceAvatar =
            marker.avatarImagePath?.contains('bean_bloom') ?? false;
        markerChildren.add(
          Positioned(
            left: width * marker.avatarLeftRatio!,
            top: height * marker.avatarTopRatio!,
            child: _MapAvatar(
              size: isLargePlaceAvatar ? 44 : 30,
              imagePath: marker.avatarImagePath ?? 'assets/images/profile.jpg',
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
            child: MapPlaceMarker(
              rating: marker.rating,
              isSelected: marker.id == selectedMarkerId,
              onTap: marker.canSelectPreview ? () => onMarkerTap(marker) : null,
            ),
          ),
        );
      }
    }

    if (showCurrentLocation) {
      markerChildren.add(
        Positioned(
          left: width * (132 / 390),
          top: height * (355 / 844),
          child: const _CurrentLocationPing(),
        ),
      );
    }

    return Stack(children: markerChildren);
  }
}

class _MapAvatar extends StatelessWidget {
  final double size;
  final String imagePath;
  final int? tintHex;

  const _MapAvatar({required this.size, required this.imagePath, this.tintHex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: ColorFiltered(
          colorFilter: tintHex == null
              ? const ColorFilter.mode(Colors.transparent, BlendMode.dst)
              : ColorFilter.mode(
                  Color(tintHex!).withValues(alpha: 0.28),
                  BlendMode.srcATop,
                ),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _CurrentLocationPing extends StatelessWidget {
  const _CurrentLocationPing();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF4487FF).withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: const Color(0xFF4487FF),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ],
      ),
    );
  }
}
