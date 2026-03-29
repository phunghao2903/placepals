import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_feed.dart';
import '../../domain/entities/create_moment_friend.dart';
import '../../domain/entities/create_moment_place.dart';
import '../../domain/entities/create_moment_vibe_tag.dart';
import '../bloc/create_moment_bloc.dart';
import '../widgets/create_moment_metadata_card.dart';
import '../widgets/create_moment_photo_tile.dart';
import '../widgets/create_moment_privacy_card.dart';
import 'create_moment_friends_page.dart';
import 'create_moment_location_page.dart';
import 'create_moment_media_picker_page.dart';
import 'create_moment_tags_page.dart';

class CreateMomentPage extends StatelessWidget {
  const CreateMomentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateMomentBloc>(
      create: (_) =>
          getIt<CreateMomentBloc>()..add(const CreateMomentStarted()),
      child: const _CreateMomentView(),
    );
  }
}

class _CreateMomentView extends StatefulWidget {
  const _CreateMomentView();

  @override
  State<_CreateMomentView> createState() => _CreateMomentViewState();
}

class _CreateMomentViewState extends State<_CreateMomentView> {
  late final TextEditingController _captionController;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<CreateMomentBloc, CreateMomentState>(
          listenWhen: (previous, current) =>
              previous.caption != current.caption ||
              previous.submissionStatus != current.submissionStatus ||
              previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            if (_captionController.text != state.caption) {
              _captionController.value = TextEditingValue(
                text: state.caption,
                selection: TextSelection.collapsed(
                  offset: state.caption.length,
                ),
              );
            }

            if (state.submissionStatus ==
                CreateMomentSubmissionStatus.success) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Moment shared successfully.')),
                );
            } else if (state.submissionStatus ==
                    CreateMomentSubmissionStatus.failure &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case CreateMomentStatus.initial:
              case CreateMomentStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case CreateMomentStatus.failure:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Something went wrong.',
                    style: AppTextStyles.body2,
                  ),
                );
              case CreateMomentStatus.success:
                final feed = state.feed;
                if (feed == null) return const SizedBox.shrink();
                return _CreateMomentContent(
                  feed: feed,
                  state: state,
                  captionController: _captionController,
                  onPickMedia: _openMediaPicker,
                  onOpenLocation: _openLocationPicker,
                  onOpenTags: _openTagsPage,
                  onOpenFriends: _openFriendsPage,
                );
            }
          },
        ),
      ),
    );
  }

  Future<void> _openMediaPicker() async {
    final bloc = context.read<CreateMomentBloc>();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: const CreateMomentMediaPickerPage(),
        ),
      ),
    );
  }

  Future<void> _openLocationPicker() async {
    final bloc = context.read<CreateMomentBloc>();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: const CreateMomentLocationPage(),
        ),
      ),
    );
  }

  Future<void> _openFriendsPage() async {
    final bloc = context.read<CreateMomentBloc>();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: const CreateMomentFriendsPage(),
        ),
      ),
    );
  }

  Future<void> _openTagsPage() async {
    final bloc = context.read<CreateMomentBloc>();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: const CreateMomentTagsPage(),
        ),
      ),
    );
  }
}

class _CreateMomentContent extends StatelessWidget {
  final CreateMomentFeed feed;
  final CreateMomentState state;
  final TextEditingController captionController;
  final VoidCallback onPickMedia;
  final VoidCallback onOpenLocation;
  final VoidCallback onOpenTags;
  final VoidCallback onOpenFriends;

  const _CreateMomentContent({
    required this.feed,
    required this.state,
    required this.captionController,
    required this.onPickMedia,
    required this.onOpenLocation,
    required this.onOpenTags,
    required this.onOpenFriends,
  });

  @override
  Widget build(BuildContext context) {
    final selectedPhotos = state.selectedPhotos;
    final primaryPhoto = selectedPhotos.isNotEmpty
        ? selectedPhotos.first
        : null;
    final secondaryPhoto = selectedPhotos.length > 1 ? selectedPhotos[1] : null;
    final selectedLocation = _findSelectedLocation(feed, state);
    final selectedVibeTags = state.selectedVibeTags;
    final selectedFriends = _selectedFriends(feed, state);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        15,
        24,
        15,
        MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Header(title: feed.title, draftsLabel: feed.draftsLabel),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth - 10) / 2;
              return Row(
                children: <Widget>[
                  SizedBox(
                    width: tileWidth,
                    child: CreateMomentPhotoTile(
                      imagePath: primaryPhoto?.imagePath,
                      label: feed.addPhotoLabel,
                      isPlaceholder: primaryPhoto == null,
                      selectionBadge: 0,
                      onTap: onPickMedia,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: tileWidth,
                    child: CreateMomentPhotoTile(
                      imagePath: secondaryPhoto?.imagePath,
                      label: feed.addPhotoLabel,
                      isPlaceholder: secondaryPhoto == null,
                      selectionBadge: 0,
                      onTap: onPickMedia,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 29),
          Text(
            feed.rateTitle,
            style: AppTextStyles.body1.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                feed.rateSubtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                state.rating.toStringAsFixed(1),
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.primary,
                  fontSize: 30,
                ),
              ),
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '/5',
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 12,
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppSemanticColors.secondary,
              thumbColor: AppColors.surface,
              overlayColor: Colors.transparent,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.5),
              trackShape: const RoundedRectSliderTrackShape(),
              trackGap: 0,
            ),
            child: Slider(
              min: 1,
              max: 5,
              divisions: 40,
              value: state.rating,
              padding: EdgeInsets.zero,
              onChanged: (value) {
                context.read<CreateMomentBloc>().add(
                  CreateMomentRatingChanged(rating: value),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(
              5,
              (index) => SizedBox(
                width: 18,
                child: Text(
                  '${index + 1}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Text(
            feed.captionTitle,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 23),
          _CaptionCard(
            controller: captionController,
            hintText: feed.captionHint,
            onTagsTap: onOpenTags,
          ),
          const SizedBox(height: 24),
          CreateMomentMetadataCard(
            icon: Icons.local_fire_department_rounded,
            title: feed.vibeTagsTitle,
            subtitle: _vibeTagsSubtitle(
              selectedVibeTags,
              fallback: feed.vibeTagsSubtitle,
            ),
            onTap: onOpenTags,
          ),
          const SizedBox(height: 16),
          CreateMomentMetadataCard(
            icon: Icons.person_add_alt_1_rounded,
            title: feed.tagFriendsTitle,
            subtitle: selectedFriends.isEmpty
                ? feed.tagFriendsHint
                : '${selectedFriends.length} friend${selectedFriends.length == 1 ? '' : 's'} tagged',
            onTap: onOpenFriends,
            trailing: selectedFriends.isEmpty
                ? null
                : _SelectedFriendsTrailing(friends: selectedFriends),
          ),
          const SizedBox(height: 16),
          CreateMomentPrivacyCard(
            title: feed.privacyTitle,
            subtitle: feed.privacyHint,
            options: feed.privacyOptions,
            selectedId: state.selectedPrivacyId,
            onSelected: (privacyId) {
              context.read<CreateMomentBloc>().add(
                CreateMomentPrivacySelected(privacyId: privacyId),
              );
            },
          ),
          const SizedBox(height: 16),
          _LocationCard(
            title: selectedLocation?.title ?? feed.locationTitle,
            subtitle: selectedLocation?.subtitle ?? feed.locationHint,
            onTap: onOpenLocation,
          ),
          const SizedBox(height: 39),
          SizedBox(
            width: double.infinity,
            height: 59,
            child: FilledButton.icon(
              onPressed: state.canSubmit
                  ? () {
                      context.read<CreateMomentBloc>().add(
                        const CreateMomentSubmitted(),
                      );
                    }
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.textSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: _ShareButtonIcon(status: state.submissionStatus),
              label: Text(
                _shareButtonLabel(feed.shareLabel, state.submissionStatus),
                style: AppTextStyles.heading4.copyWith(
                  color: SemanticTextColors.onBrand,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CreateMomentPlace? _findSelectedLocation(
    CreateMomentFeed feed,
    CreateMomentState state,
  ) {
    for (final place in feed.nearbyPlaces) {
      if (place.id == state.selectedLocationId) {
        return place;
      }
    }
    return null;
  }

  List<CreateMomentFriend> _selectedFriends(
    CreateMomentFeed feed,
    CreateMomentState state,
  ) {
    final selected = <CreateMomentFriend>[];
    for (final id in state.selectedFriendIds) {
      for (final friend in feed.friends) {
        if (friend.id == id) {
          selected.add(friend);
          break;
        }
      }
    }
    return selected;
  }

  String _vibeTagsSubtitle(
    List<CreateMomentVibeTag> selectedTags, {
    required String fallback,
  }) {
    if (selectedTags.isEmpty) return fallback;

    final labels = selectedTags.map((tag) => tag.label).take(2).join(', ');
    if (selectedTags.length <= 2) return labels;

    final remaining = selectedTags.length - 2;
    return '$labels +$remaining';
  }

  String _shareButtonLabel(
    String defaultLabel,
    CreateMomentSubmissionStatus status,
  ) {
    switch (status) {
      case CreateMomentSubmissionStatus.submitting:
        return 'Sharing...';
      case CreateMomentSubmissionStatus.success:
        return 'Shared';
      case CreateMomentSubmissionStatus.idle:
      case CreateMomentSubmissionStatus.failure:
        return defaultLabel;
    }
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String draftsLabel;

  const _Header({required this.title, required this.draftsLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: AppColors.textPrimary,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 24, height: 24),
        ),
        const SizedBox(width: 65),
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

class _CaptionCard extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onTagsTap;

  const _CaptionCard({
    required this.controller,
    required this.hintText,
    required this.onTagsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 131,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
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
          TextField(
            controller: controller,
            onChanged: (value) {
              context.read<CreateMomentBloc>().add(
                CreateMomentCaptionChanged(caption: value),
              );
            },
            minLines: 5,
            maxLines: 5,
            style: AppTextStyles.body1.copyWith(color: AppColors.textPrimary),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: onTagsTap,
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.sentiment_satisfied_alt_rounded,
                      color: Color(0xFF9C9493),
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: onTagsTap,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '#',
                      style: AppTextStyles.body1.copyWith(
                        color: const Color(0xFF9C9493),
                      ),
                    ),
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

class _LocationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LocationCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          height: 85,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18),
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
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppSemanticColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedFriendsTrailing extends StatelessWidget {
  final List<CreateMomentFriend> friends;

  const _SelectedFriendsTrailing({required this.friends});

  @override
  Widget build(BuildContext context) {
    final preview = friends.take(3).toList(growable: false);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 42,
          height: 24,
          child: Stack(
            children: List<Widget>.generate(
              preview.length,
              (index) => Positioned(
                left: index * 12,
                child: _FriendAvatarBubble(name: preview[index].name),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF9C9493),
          size: 20,
        ),
      ],
    );
  }
}

class _FriendAvatarBubble extends StatelessWidget {
  final String name;

  const _FriendAvatarBubble({required this.name});

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0])
        .join();
    final palette = <Color>[
      const Color(0xFFFFD8D2),
      const Color(0xFFFFEDCC),
      const Color(0xFFDDEAFE),
      const Color(0xFFE7D9FF),
    ];
    final background = palette[name.length % palette.length];

    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.2),
      ),
      child: Text(
        initials,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.textPrimary,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _ShareButtonIcon extends StatelessWidget {
  final CreateMomentSubmissionStatus status;

  const _ShareButtonIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case CreateMomentSubmissionStatus.submitting:
        return const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2.2,
            valueColor: AlwaysStoppedAnimation<Color>(
              SemanticTextColors.onBrand,
            ),
          ),
        );
      case CreateMomentSubmissionStatus.success:
        return const Icon(
          Icons.check_rounded,
          size: 22,
          color: SemanticTextColors.onBrand,
        );
      case CreateMomentSubmissionStatus.idle:
      case CreateMomentSubmissionStatus.failure:
        return const Icon(
          Icons.send_rounded,
          size: 22,
          color: SemanticTextColors.onBrand,
        );
    }
  }
}
