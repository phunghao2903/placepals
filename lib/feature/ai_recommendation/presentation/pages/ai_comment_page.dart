import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/ai_recommendation_friend_review.dart';
import '../bloc/ai_recommendation_bloc.dart';
import '../widgets/ai_screen_header.dart';
import 'ai_map_page.dart';
import 'ai_review_page.dart';

class AiCommentPage extends StatelessWidget {
  const AiCommentPage({super.key});

  void _openMapPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<AiRecommendationBloc>(),
          child: const AiMapPage(),
        ),
      ),
    );
  }

  void _openReviewPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<AiRecommendationBloc>(),
          child: const AiReviewPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final feed = context.read<AiRecommendationBloc>().state.feed;
    if (feed == null) {
      return const SizedBox.shrink();
    }

    final comment = feed.commentFeed;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBFA),
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
                          AiCircleIconButton(
                            icon: Icons.arrow_back_rounded,
                            onTap: () => Navigator.of(context).pop(),
                            backgroundColor: const Color(0x662D2D2D),
                            iconColor: Colors.white,
                            boxShadow: const <BoxShadow>[],
                          ),
                          const AiCircleIconButton(
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
                    left: 0,
                    right: 0,
                    bottom: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(3, (index) {
                        final isActive = index == 1;
                        return Container(
                          width: isActive ? 8 : 7,
                          height: isActive ? 8 : 7,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : const Color(0x88FFFFFF),
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
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
                          '${comment.category}  •  ${comment.priceLabel}  •  ${comment.distanceLabel}',
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
                          child: _PrimaryActionButton(
                            icon: Icons.near_me_rounded,
                            label: comment.primaryActionLabel,
                            onTap: () => _openMapPage(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SecondaryActionButton(
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
                                      style: AppTextStyles.heading5.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      comment.friendsSectionSubtitle,
                                      style: AppTextStyles.body2.copyWith(
                                        fontSize: 14,
                                      ),
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
                            final index = entry.key;
                            final item = entry.value;
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    index == comment.friendReviews.length - 1
                                        ? 0
                                        : 18,
                              ),
                              child: _FriendReviewTile(review: item),
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
                      style: AppTextStyles.heading5.copyWith(fontSize: 18),
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
                                                '${comment.statusLabel}  ${comment.closingLabel}',
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
                                        const AiCircleIconButton(
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

class _PrimaryActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _PrimaryActionButton({
    required this.icon,
    required this.label,
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
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTextStyles.heading6.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SecondaryActionButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFEDE3E1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: const Color(0xFF20263A), size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: AppTextStyles.body1.copyWith(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendReviewTile extends StatelessWidget {
  final AiRecommendationFriendReview review;

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
          backgroundImage:
              review.avatarImagePath != null ? AssetImage(review.avatarImagePath!) : null,
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
