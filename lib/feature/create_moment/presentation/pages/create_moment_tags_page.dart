import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/create_moment_bloc.dart';
import '../widgets/create_moment_photo_tile.dart';
import '../widgets/create_moment_vibe_chip.dart';

class CreateMomentTagsPage extends StatelessWidget {
  const CreateMomentTagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<CreateMomentBloc, CreateMomentState>(
        builder: (context, state) {
          final feed = state.feed;
          if (feed == null) return const SizedBox.shrink();

          final previewPhoto = state.selectedPhotos.isNotEmpty
              ? state.selectedPhotos.first
              : null;
          final topPadding = MediaQuery.paddingOf(context).top;
          final tags = state.allVibeTags;

          return Stack(
            children: <Widget>[
              Container(color: const Color(0x332D2D2D)),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, topPadding + 31, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _TagsOverlayHeader(
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
                  child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: 72,
                              height: 7,
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(20),
                              ),
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
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
                          Text(
                            feed.captionTitle,
                            style: AppTextStyles.heading3.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _CaptionPreview(
                            text: state.caption,
                            hint: feed.captionHint,
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: <Widget>[
                              Text(
                                feed.vibeTagsTitle,
                                style: AppTextStyles.heading3.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                feed.vibeTagsSubtitle,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 14,
                            children: tags
                                .map(
                                  (tag) => CreateMomentVibeChip(
                                    label: tag.label,
                                    iconKey: tag.iconKey,
                                    isSelected: state.selectedTagIds.contains(
                                      tag.id,
                                    ),
                                    onTap: () async {
                                      if (tag.id == 'add-tag') {
                                        final label = await _showAddTagDialog(
                                          context,
                                        );
                                        if (label != null && context.mounted) {
                                          context.read<CreateMomentBloc>().add(
                                            CreateMomentCustomTagAdded(
                                              label: label,
                                            ),
                                          );
                                        }
                                        return;
                                      }

                                      context.read<CreateMomentBloc>().add(
                                        CreateMomentVibeTagToggled(
                                          tagId: tag.id,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(growable: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<String?> _showAddTagDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (_) => const _AddTagDialog(),
    );
  }
}

class _AddTagDialog extends StatefulWidget {
  const _AddTagDialog();

  @override
  State<_AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<_AddTagDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add custom tag'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Type a vibe tag'),
        onSubmitted: _submit,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _submit(_controller.text),
          child: const Text('Add'),
        ),
      ],
    );
  }

  void _submit(String value) {
    Navigator.of(context).pop(value.trim());
  }
}

class _TagsOverlayHeader extends StatelessWidget {
  final String title;
  final String draftsLabel;

  const _TagsOverlayHeader({required this.title, required this.draftsLabel});

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

class _CaptionPreview extends StatelessWidget {
  final String text;
  final String hint;

  const _CaptionPreview({required this.text, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 131,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Text(
            text.isEmpty ? hint : text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body2.copyWith(
              color: text.isEmpty
                  ? AppColors.textSecondary
                  : AppColors.textPrimary,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.sentiment_satisfied_alt_rounded,
                  color: Color(0xFF9C9493),
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  '#',
                  style: AppTextStyles.body1.copyWith(
                    color: const Color(0xFF9C9493),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
