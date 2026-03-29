import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/map_place.dart';
import '../bloc/map_bloc.dart';
import '../widgets/map_related_guide_card.dart';

class MapPlaceDetailPage extends StatelessWidget {
  const MapPlaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MapPlaceDetailView();
  }
}

class _MapPlaceDetailView extends StatefulWidget {
  const _MapPlaceDetailView();

  @override
  State<_MapPlaceDetailView> createState() => _MapPlaceDetailViewState();
}

class _MapPlaceDetailViewState extends State<_MapPlaceDetailView> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: SizedBox(
          height: 60,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).maybePop(),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            icon: const Icon(Icons.route_outlined, color: Colors.white),
            label: Text(
              'Get Directions',
              style: AppTextStyles.body1.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      body: BlocConsumer<MapBloc, MapState>(
        listenWhen: (previous, current) =>
            previous.detailNote != current.detailNote,
        listener: (context, state) {
          if (_notesController.text != state.detailNote) {
            _notesController.value = TextEditingValue(
              text: state.detailNote,
              selection: TextSelection.collapsed(
                offset: state.detailNote.length,
              ),
            );
          }
        },
        builder: (context, state) {
          final feed = state.feed;
          if (feed == null) {
            return const SizedBox.shrink();
          }

          final place = feed.detailPlace;
          if (_notesController.text != state.detailNote) {
            _notesController.value = TextEditingValue(
              text: state.detailNote,
              selection: TextSelection.collapsed(
                offset: state.detailNote.length,
              ),
            );
          }

          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 360,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.asset(place.heroImagePath, fit: BoxFit.cover),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Colors.black.withValues(alpha: 0.45),
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.60),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -34),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 104),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                child: Container(
                                  width: 48,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8E0DF),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          place.title,
                                          style: AppTextStyles.heading2
                                              .copyWith(
                                                color: AppColors.textPrimary,
                                              ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: <Widget>[
                                            _Badge(label: place.categoryLabel),
                                            const SizedBox(width: 8),
                                            Text(
                                              '•',
                                              style: AppTextStyles.body2
                                                  .copyWith(
                                                    color: AppColors.primary,
                                                  ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              place.priceLabel,
                                              style: AppTextStyles.body2
                                                  .copyWith(
                                                    color: AppColors.primary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<MapBloc>().add(
                                        const MapDetailSavedToggled(),
                                      );
                                    },
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE3DAD9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        place.isSaved
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: <Widget>[
                                  Text(
                                    place.rating.toStringAsFixed(1),
                                    style: AppTextStyles.heading3.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ...List<Widget>.generate(
                                    5,
                                    (index) => const Icon(
                                      Icons.star_rounded,
                                      size: 18,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    place.reviewLabel,
                                    style: AppTextStyles.body2.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _DetailInfoCard(place: place),
                              const SizedBox(height: 22),
                              Text(
                                'Your Notes',
                                style: AppTextStyles.heading3.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    TextField(
                                      controller: _notesController,
                                      onChanged: (value) {
                                        context.read<MapBloc>().add(
                                          MapDetailNoteChanged(note: value),
                                        );
                                      },
                                      maxLines: 4,
                                      style: AppTextStyles.body2.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                              16,
                                              16,
                                              16,
                                              36,
                                            ),
                                        hintText: place.noteHint,
                                        hintStyle: AppTextStyles.body2.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          borderSide: const BorderSide(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      right: 14,
                                      bottom: 14,
                                      child: Icon(
                                        Icons.edit_note_rounded,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Related Guides',
                                      style: AppTextStyles.heading3.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'View all',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 296,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: place.relatedGuides.length,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(width: 16),
                                  itemBuilder: (context, index) {
                                    return MapRelatedGuideCard(
                                      guide: place.relatedGuides[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _HeaderCircleButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                      const _HeaderCircleButton(icon: Icons.ios_share_rounded),
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
}

class _HeaderCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _HeaderCircleButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.25),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;

  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0x1AF27F0D),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _DetailInfoCard extends StatelessWidget {
  final MapPlace place;

  const _DetailInfoCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          _InfoRow(
            leadingIcon: Icons.location_on_rounded,
            title: place.locationTitle,
            subtitle: place.locationSubtitle,
            trailingIcon: Icons.chevron_right_rounded,
          ),
          _InfoRow(
            leadingIcon: Icons.access_time_filled_rounded,
            title: place.openStatusLabel,
            titleColor: AppColors.success,
            trailingText: place.closeStatusLabel,
            trailingTextColor: AppColors.error,
            subtitle: place.hoursLabel,
            trailingIcon: Icons.expand_more_rounded,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final String? trailingText;
  final Color? titleColor;
  final Color? trailingTextColor;
  final IconData trailingIcon;

  const _InfoRow({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
    this.trailingText,
    this.titleColor,
    this.trailingTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2))),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0x1AF27F0D),
              shape: BoxShape.circle,
            ),
            child: Icon(leadingIcon, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTextStyles.body2.copyWith(
                        color: titleColor ?? AppColors.textPrimary,
                      ),
                    ),
                    if (trailingText != null) ...<Widget>[
                      const SizedBox(width: 10),
                      Text(
                        trailingText!,
                        style: AppTextStyles.body2.copyWith(
                          color: trailingTextColor ?? AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: subtitle == 'Full hours'
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(trailingIcon, color: AppColors.textPrimary),
        ],
      ),
    );
  }
}
