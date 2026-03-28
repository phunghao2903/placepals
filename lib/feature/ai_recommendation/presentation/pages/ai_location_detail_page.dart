import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_place_guide.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_screen_header.dart';

class AiLocationDetailPage extends StatefulWidget {
  const AiLocationDetailPage({super.key});

  @override
  State<AiLocationDetailPage> createState() => _AiLocationDetailPageState();
}

class _AiLocationDetailPageState extends State<AiLocationDetailPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AiRecommendationBloc>().state.placeNote,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiRecommendationBloc, AiRecommendationState>(
      listenWhen: (previous, current) => previous.placeNote != current.placeNote,
      listener: (context, state) {
        if (_controller.text != state.placeNote) {
          _controller.value = TextEditingValue(
            text: state.placeNote,
            selection: TextSelection.collapsed(offset: state.placeNote.length),
          );
        }
      },
      builder: (context, state) {
        final feed = state.feed;
        if (feed == null) {
          return const SizedBox.shrink();
        }

        final detail = feed.locationDetail;

        return Scaffold(
          backgroundColor: const Color(0xFFFFFBFA),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 258,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(detail.imagePath, fit: BoxFit.cover),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0x66000000), Color(0x12000000)],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            AiCircleIconButton(
                              icon: Icons.arrow_back_rounded,
                              onTap: () => Navigator.of(context).pop(),
                              backgroundColor: const Color(0x4D2D2D2D),
                              iconColor: Colors.white,
                              boxShadow: const <BoxShadow>[],
                            ),
                            const AiCircleIconButton(
                              icon: Icons.ios_share_rounded,
                              backgroundColor: Color(0x4D2D2D2D),
                              iconColor: Colors.white,
                              boxShadow: <BoxShadow>[],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Transform.translate(
                    offset: const Offset(0, -32),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(28),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      detail.title,
                                      style: AppTextStyles.heading2.copyWith(
                                        fontSize: 30,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF7EFED),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.favorite_border_rounded,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${detail.category}  â€¢  ${detail.priceLabel}',
                                style: AppTextStyles.body2.copyWith(
                                  fontSize: 14,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(18),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      detail.rating.toStringAsFixed(1),
                                      style: AppTextStyles.heading5.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ...List<Widget>.generate(
                                      5,
                                      (index) => const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          Icons.star_rounded,
                                          color: AppColors.warning,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      detail.reviewsLabel,
                                      style: AppTextStyles.body2.copyWith(
                                        fontSize: 14,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFBFA),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    _InfoRow(
                                      icon: Icons.location_on_outlined,
                                      title: detail.addressTitle,
                                      subtitle: detail.addressSubtitle,
                                      trailing: const Icon(
                                        Icons.chevron_right_rounded,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const Divider(height: 26),
                                    _InfoRow(
                                      icon: Icons.access_time_rounded,
                                      title: detail.statusLabel,
                                      subtitle: detail.hoursLabel,
                                      titleColor: const Color(0xFF22C55E),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            detail.closingLabel,
                                            style: AppTextStyles.body2.copyWith(
                                              fontSize: 14,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Icon(
                                            Icons.expand_more_rounded,
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                detail.notesTitle,
                                style: AppTextStyles.heading5.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFAFB6C3),
                                  ),
                                ),
                                child: TextField(
                                  controller: _controller,
                                  minLines: 3,
                                  maxLines: 3,
                                  onChanged: (value) {
                                    context.read<AiRecommendationBloc>().add(
                                          AiRecommendationPlaceNoteChanged(
                                            note: value,
                                          ),
                                        );
                                  },
                                  decoration: InputDecoration(
                                    hintText: detail.notePlaceholder,
                                    hintStyle: AppTextStyles.body2.copyWith(
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(16),
                                    suffixIcon: const Padding(
                                      padding: EdgeInsets.only(
                                        right: 10,
                                        bottom: 10,
                                      ),
                                      child: Icon(
                                        Icons.edit_note_rounded,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      detail.guidesTitle,
                                      style: AppTextStyles.heading5.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    detail.guidesActionLabel,
                                    style: AppTextStyles.body2.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              SizedBox(
                                height: 220,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: detail.guides.length,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    return _GuideCard(
                                      guide: detail.guides[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      icon: const Icon(Icons.diamond_outlined),
                      label: Text(
                        detail.directionsLabel,
                        style: AppTextStyles.heading5.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final Color? titleColor;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0x1FFF6B5A),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTextStyles.body1.copyWith(
                  fontSize: 16,
                  color: titleColor ?? AppColors.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: AppTextStyles.body2.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
        trailing,
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  final AiRecommendationPlaceGuide guide;

  const _GuideCard({
    required this.guide,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 128,
              height: 138,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(guide.imagePath, fit: BoxFit.cover),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xAA2D2D2D),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        guide.label,
                        style: AppTextStyles.heading8.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            guide.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.heading7.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            guide.subtitle,
            style: AppTextStyles.body2.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
