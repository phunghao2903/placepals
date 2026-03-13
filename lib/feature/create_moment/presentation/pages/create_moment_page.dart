import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_feed.dart';
import '../../domain/entities/create_moment_photo.dart';
import '../bloc/create_moment_bloc.dart';
import '../widgets/create_moment_photo_tile.dart';

class CreateMomentPage extends StatelessWidget {
  const CreateMomentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateMomentBloc>(
      create: (_) => getIt<CreateMomentBloc>()..add(const CreateMomentStarted()),
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
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _captionController.dispose();
    _locationController.dispose();
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
              previous.location != current.location,
          listener: (context, state) {
            if (_captionController.text != state.caption) {
              _captionController.value = TextEditingValue(
                text: state.caption,
                selection: TextSelection.collapsed(offset: state.caption.length),
              );
            }
            if (_locationController.text != state.location) {
              _locationController.value = TextEditingValue(
                text: state.location,
                selection: TextSelection.collapsed(offset: state.location.length),
              );
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
                  locationController: _locationController,
                );
            }
          },
        ),
      ),
    );
  }
}

class _CreateMomentContent extends StatelessWidget {
  final CreateMomentFeed feed;
  final CreateMomentState state;
  final TextEditingController captionController;
  final TextEditingController locationController;

  const _CreateMomentContent({
    required this.feed,
    required this.state,
    required this.captionController,
    required this.locationController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 24, 15, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Header(
            title: feed.title,
            draftsLabel: feed.draftsLabel,
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: feed.photos
                  .map(
                    (CreateMomentPhoto photo) => CreateMomentPhotoTile(
                      photo: photo,
                      addPhotoLabel: feed.addPhotoLabel,
                    ),
                  )
                  .toList(growable: false),
            ),
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
          SizedBox(
            width: 360,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 12,
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: AppSemanticColors.secondary,
                thumbColor: AppColors.surface,
                overlayColor: Colors.transparent,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 12.5),
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
          ),
          SizedBox(
            width: 360,
            child: Row(
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
          ),
          const SizedBox(height: 41),
          Text(
            feed.captionTitle,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 23),
          _InputCard(
            height: 131,
            child: TextField(
              controller: captionController,
              onChanged: (value) {
                context.read<CreateMomentBloc>().add(
                      CreateMomentCaptionChanged(caption: value),
                    );
              },
              maxLines: 5,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: feed.captionHint,
                hintStyle: AppTextStyles.body1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          _LocationCard(
            title: feed.locationTitle,
            hintText: feed.locationHint,
            controller: locationController,
          ),
          const SizedBox(height: 39),
          SizedBox(
            width: double.infinity,
            height: 59,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Share Moment is not connected yet.'),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(
                Icons.send_rounded,
                size: 22,
                color: SemanticTextColors.onBrand,
              ),
              label: Text(
                feed.shareLabel,
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
}

class _Header extends StatelessWidget {
  final String title;
  final String draftsLabel;

  const _Header({
    required this.title,
    required this.draftsLabel,
  });

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
          style: AppTextStyles.body2.copyWith(
            color: AppColors.primary,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _InputCard extends StatelessWidget {
  final double height;
  final Widget child;

  const _InputCard({
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
      child: child,
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;

  const _LocationCard({
    required this.title,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  style: AppTextStyles.body1.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                TextField(
                  controller: controller,
                  onChanged: (value) {
                    context.read<CreateMomentBloc>().add(
                          CreateMomentLocationChanged(location: value),
                        );
                  },
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ],
      ),
    );
  }
}
