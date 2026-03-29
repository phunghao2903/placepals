import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_photo.dart';
import '../bloc/create_moment_bloc.dart';
import '../widgets/create_moment_media_grid_tile.dart';
import '../widgets/create_moment_photo_tile.dart';
import 'create_moment_take_photo_page.dart';

class CreateMomentMediaPickerPage extends StatelessWidget {
  const CreateMomentMediaPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<CreateMomentBloc, CreateMomentState>(
        builder: (context, state) {
          final feed = state.feed;
          if (feed == null) return const SizedBox.shrink();

          final selectedPhotos = state.selectedPhotos;
          final previewPhoto = selectedPhotos.isNotEmpty
              ? selectedPhotos.first
              : null;
          final previewPhotos = _orderedPhotos(state.availablePhotos);
          final topPadding = MediaQuery.paddingOf(context).top;
          final selectionCount = state.selectedMediaIds.length;

          return Stack(
            children: <Widget>[
              Container(color: const Color(0x332D2D2D)),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, topPadding + 31, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _OverlayHeader(
                        title: feed.title,
                        draftsLabel: feed.draftsLabel,
                      ),
                      const SizedBox(height: 47),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CreateMomentPhotoTile(
                              imagePath: previewPhoto?.imagePath,
                              label: feed.addPhotoLabel,
                              isPlaceholder: previewPhoto == null,
                              selectionBadge: 0,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CreateMomentPhotoTile(
                              imagePath: null,
                              label: feed.addPhotoLabel,
                              isPlaceholder: true,
                              selectionBadge: 0,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 189,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 12),
                      Container(
                        width: 72,
                        height: 7,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 56,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Text(
                                  'x',
                                  style: AppTextStyles.heading1.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                feed.mediaPickerTitle,
                                style: AppTextStyles.body1.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                              ),
                          itemCount: previewPhotos.length,
                          itemBuilder: (context, index) {
                            final photo = previewPhotos[index];
                            final selectionIndex =
                                state.selectedMediaIds.indexOf(photo.id) + 1;
                            return CreateMomentMediaGridTile(
                              photo: photo,
                              selectionIndex: photo.isPlaceholder
                                  ? 0
                                  : selectionIndex,
                              onTap: () {
                                if (photo.isPlaceholder) {
                                  final imagePath = _cameraPreviewImagePath(
                                    state,
                                  );
                                  if (imagePath == null) return;

                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<CreateMomentBloc>(),
                                        child: CreateMomentTakePhotoPage(
                                          previewImagePath: imagePath,
                                        ),
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                context.read<CreateMomentBloc>().add(
                                  CreateMomentMediaToggled(photoId: photo.id),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(29, 4, 29, 16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: FilledButton(
                              onPressed: selectionCount == 0
                                  ? null
                                  : () => Navigator.of(context).pop(),
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                disabledBackgroundColor:
                                    AppColors.textSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                selectionCount == 0
                                    ? 'Select Photos'
                                    : 'Add $selectionCount Photo${selectionCount == 1 ? '' : 's'}',
                                style: AppTextStyles.heading3.copyWith(
                                  color: SemanticTextColors.onBrand,
                                ),
                              ),
                            ),
                          ),
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
    );
  }

  List<CreateMomentPhoto> _orderedPhotos(List<CreateMomentPhoto> photos) {
    final placeholders = <CreateMomentPhoto>[];
    final images = <CreateMomentPhoto>[];
    for (final photo in photos) {
      if (photo.isPlaceholder) {
        placeholders.add(photo);
      } else {
        images.add(photo);
      }
    }
    return <CreateMomentPhoto>[...placeholders, ...images];
  }

  String? _cameraPreviewImagePath(CreateMomentState state) {
    for (final photo in state.selectedPhotos) {
      if (!photo.isPlaceholder && photo.imagePath != null) {
        return photo.imagePath;
      }
    }
    for (final photo in state.availablePhotos) {
      if (!photo.isPlaceholder && photo.imagePath != null) {
        return photo.imagePath;
      }
    }
    return null;
  }
}

class _OverlayHeader extends StatelessWidget {
  final String title;
  final String draftsLabel;

  const _OverlayHeader({required this.title, required this.draftsLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: AppColors.textPrimary,
        ),
        const Spacer(),
        Text(
          title,
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.textPrimary,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        Text(
          draftsLabel,
          style: AppTextStyles.body1.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}
