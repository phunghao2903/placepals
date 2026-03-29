import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/place_details_feed.dart';
import '../bloc/place_details_bloc.dart';
import '../widgets/place_icon_circle_button.dart';
import 'place_map_page.dart';
import 'place_review_page.dart';

class PlaceCommentPage extends StatelessWidget {
  const PlaceCommentPage({super.key});

  void _openMapPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<PlaceDetailsBloc>(),
          child: const PlaceMapPage(),
        ),
      ),
    );
  }

  void _openReviewPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<PlaceDetailsBloc>(),
          child: const PlaceReviewPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final feed = context.read<PlaceDetailsBloc>().state.feed;
    if (feed == null) {
      return const SizedBox.shrink();
    }

    final PlaceCommentData comment = feed.comment;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 362,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(comment.imagePath, fit: BoxFit.cover),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0x3A000000),
                          Color(0xB8000000),
                        ],
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
                          PlaceIconCircleButton(
                            icon: Icons.arrow_back_rounded,
                            onTap: () => Navigator.of(context).pop(),
                            backgroundColor: const Color(0x662D2D2D),
                            iconColor: Colors.white,
                            boxShadow: const <BoxShadow>[],
                          ),
                          const PlaceIconCircleButton(
                            icon: Icons.ios_share_rounded,
                            backgroundColor: Color(0x662D2D2D),
                            iconColor: Colors.white,
                            boxShadow: <BoxShadow>[],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 34,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          comment.title,
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 28,
                            height: 1.1,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${comment.category} - ${comment.priceLabel} - ${comment.distanceLabel}',
                          style: AppTextStyles.body1.copyWith(
                            color: const Color(0xFFF9D1CB),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -1),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.near_me_rounded,
                            label: comment.primaryActionLabel,
                            isPrimary: true,
                            onTap: () => _openMapPage(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.bookmark_border_rounded,
                            label: comment.secondaryActionLabel,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBFA),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x12000000),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      comment.friendsSectionTitle,
                                      style: AppTextStyles.heading5,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      comment.friendsSectionSubtitle,
                                      style: AppTextStyles.body2,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF958D8C),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      comment.ratingLabel,
                                      style: AppTextStyles.heading7.copyWith(
                                        color: AppColors.warning,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.star_rounded,
                                      color: AppColors.warning,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          ...comment.friendReviews.asMap().entries.map((entry) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: entry.key == comment.friendReviews.length - 1
                                    ? 0
                                    : 18,
                              ),
                              child: _FriendReviewTile(review: entry.value),
                            );
                          }),
                          const Divider(height: 24),
                          Center(
                            child: InkWell(
                              onTap: () {
                                _openReviewPage(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  comment.reviewsActionLabel,
                                  style: AppTextStyles.body1.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      comment.locationTitle,
                      style: AppTextStyles.heading5,
                    ),
                    const SizedBox(height: 18),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(26),
                        onTap: () => _openMapPage(context),
                        child: Container(
                          height: 232,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Color(0x12000000),
                                blurRadius: 16,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/map.png',
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  left: 32,
                                  right: 32,
                                  bottom: 14,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                comment.addressLabel,
                                                style:
                                                    AppTextStyles.body1.copyWith(
                                                  fontSize: 16,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${comment.statusLabel} - ${comment.closingLabel}',
                                                style: AppTextStyles.body2
                                                    .copyWith(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xFF22C55E),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const PlaceIconCircleButton(
                                          icon: Icons.copy_rounded,
                                          size: 34,
                                          iconSize: 18,
                                          backgroundColor: Color(0xFFF5F1F0),
                                          boxShadow: <BoxShadow>[],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.isPrimary = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: isPrimary ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: isPrimary
                ? null
                : Border.all(color: const Color(0xFFEDE3E1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: isPrimary ? Colors.white : const Color(0xFF20263A),
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style:
                    (isPrimary ? AppTextStyles.heading6 : AppTextStyles.body1)
                        .copyWith(
                  color: isPrimary ? Colors.white : AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FriendReviewTile extends StatelessWidget {
  final PlaceFriendReview review;

  const _FriendReviewTile({
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 18,
          backgroundColor: const Color(0xFFF4ECEA),
          backgroundImage: review.avatarImagePath != null
              ? AssetImage(review.avatarImagePath!)
              : null,
          child: review.avatarImagePath == null
              ? Text(
                  review.initials,
                  style: AppTextStyles.heading7.copyWith(fontSize: 14),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      review.authorHandle,
                      style: AppTextStyles.heading7.copyWith(fontSize: 16),
                    ),
                  ),
                  Text(
                    review.timeLabel,
                    style: AppTextStyles.body2.copyWith(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                review.content,
                style: AppTextStyles.body2.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF8A7F7E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
