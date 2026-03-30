import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/core.dart';
import '../../domain/entities/profile_feed.dart';
import 'edit_place_page.dart';

const Color _postDetailCanvas = Color(0xFFFFFAF8);
const Color _postDetailStroke = Color(0xFFF3E8E5);
const Color _postDetailAccent = Color(0xFFFF6B5A);
const Color _postDetailMutedFill = Color(0xFFF4F0EF);

class PostDetailPage extends StatelessWidget {
  final ProfilePlaceItem place;

  const PostDetailPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final detail = _PostDetailSeed.fromPlace(place);

    return Scaffold(
      backgroundColor: _postDetailCanvas,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _PostDetailHeader(
                      onBack: () => Navigator.of(context).pop(),
                      onMore: () => _showMoreStub(context),
                    ),
                    const SizedBox(height: 18),
                    _PostAuthorCard(place: place, detail: detail),
                    const SizedBox(height: 18),
                    _PostHeroImage(place: place),
                    const SizedBox(height: 18),
                    Text(
                      detail.caption,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: detail.tags
                          .map((tag) => _PostTagChip(label: tag))
                          .toList(growable: false),
                    ),
                    const SizedBox(height: 18),
                    _PostSocialRow(
                      avatarPath: detail.avatarPath,
                      socialLabel: detail.socialLabel,
                    ),
                  ],
                ),
              ),
            ),
            _PostActionBar(
              onEdit: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => EditPlacePage(place: place),
                  ),
                );
              },
              onShare: () => _sharePost(detail),
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreStub(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('More options for ${place.title} are not available yet.'),
      ),
    );
  }

  Future<void> _sharePost(_PostDetailSeed detail) async {
    final shareText = StringBuffer()
      ..writeln(place.title)
      ..writeln('${place.city}, Vietnam')
      ..writeln()
      ..writeln(detail.caption)
      ..writeln()
      ..writeln('Rating: ${place.rating.toStringAsFixed(1)}')
      ..writeln('Views: ${place.views}  Likes: ${place.likes}')
      ..writeln('Tags: ${detail.tags.map((tag) => '#$tag').join(' ')}');

    await SharePlus.instance.share(
      ShareParams(
        text: shareText.toString().trim(),
        subject: 'Check out ${place.title} on PlacePals',
      ),
    );
  }
}

class _PostDetailHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMore;

  const _PostDetailHeader({required this.onBack, required this.onMore});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CircleButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        Expanded(
          child: Text(
            'Post Details',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _CircleButton(
          icon: Icons.more_vert_rounded,
          onTap: onMore,
        ),
      ],
    );
  }
}

class _PostAuthorCard extends StatelessWidget {
  final ProfilePlaceItem place;
  final _PostDetailSeed detail;

  const _PostAuthorCard({required this.place, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14111827),
                blurRadius: 16,
                offset: Offset(0, 10),
                spreadRadius: -12,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(detail.avatarPath, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                detail.authorName,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: <Widget>[
                  Text(
                    detail.username,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    detail.timeLabel,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  _MetaPill(
                    icon: Icons.public_rounded,
                    label: detail.visibilityLabel,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${place.city}, Vietnam',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PostHeroImage extends StatelessWidget {
  final ProfilePlaceItem place;

  const _PostHeroImage({required this.place});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Stack(
        children: <Widget>[
          Image.asset(
            place.imagePath,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Colors.black.withValues(alpha: 0.14),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(999),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x14111827),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                    spreadRadius: -10,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  5,
                  (index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: _postDetailAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostSocialRow extends StatelessWidget {
  final String avatarPath;
  final String socialLabel;

  const _PostSocialRow({
    required this.avatarPath,
    required this.socialLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF7F6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _postDetailStroke),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 52,
            height: 24,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                _StackedAvatar(
                  avatarPath: avatarPath,
                  left: 0,
                  borderColor: const Color(0xFFFBF7F6),
                ),
                _StackedAvatar(
                  avatarPath: avatarPath,
                  left: 14,
                  borderColor: const Color(0xFFFBF7F6),
                  tint: Colors.black.withValues(alpha: 0.1),
                ),
                Positioned(
                  left: 30,
                  top: 4,
                  child: Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _postDetailAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFBF7F6), width: 2),
                    ),
                    child: Text(
                      '+1',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              socialLabel,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _PostActionBar extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onShare;

  const _PostActionBar({required this.onEdit, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: const BoxDecoration(
        color: _postDetailCanvas,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x10111827),
            blurRadius: 20,
            offset: Offset(0, -8),
            spreadRadius: -16,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onEdit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: _postDetailAccent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: Text(
                  'Edit Post',
                  style: AppTextStyles.body2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onShare,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: _postDetailMutedFill,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                icon: const Icon(Icons.share_outlined, size: 18),
                label: Text(
                  'Share Post',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostTagChip extends StatelessWidget {
  final String label;

  const _PostTagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFEA),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.caption.copyWith(
          color: _postDetailAccent,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _postDetailStroke),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 12, color: _postDetailAccent),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StackedAvatar extends StatelessWidget {
  final String avatarPath;
  final double left;
  final Color borderColor;
  final Color? tint;

  const _StackedAvatar({
    required this.avatarPath,
    required this.left,
    required this.borderColor,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: 0,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 2),
        ),
        child: ClipOval(
          child: ColoredBox(
            color: tint ?? Colors.transparent,
            child: Image.asset(avatarPath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _postDetailStroke),
          ),
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _PostDetailSeed {
  final String authorName;
  final String username;
  final String timeLabel;
  final String visibilityLabel;
  final String avatarPath;
  final String caption;
  final List<String> tags;
  final String socialLabel;

  const _PostDetailSeed({
    required this.authorName,
    required this.username,
    required this.timeLabel,
    required this.visibilityLabel,
    required this.avatarPath,
    required this.caption,
    required this.tags,
    required this.socialLabel,
  });

  factory _PostDetailSeed.fromPlace(ProfilePlaceItem place) {
    switch (place.id) {
      case 'garden_terrace':
      case 'garden_terrace_hoi_an':
        return const _PostDetailSeed(
          authorName: 'Sarah Johnson',
          username: '@sarahjohnson',
          timeLabel: '3h ago',
          visibilityLabel: 'PUBLIC',
          avatarPath: 'assets/images/profile.jpg',
          caption:
              'Morning light, quiet tables, and a breezy garden corner make this one of my favorite brunch spots in town.',
          tags: <String>['cozy', 'brunch', 'garden'],
          socialLabel: 'With Emma and 3 others',
        );
      case 'sunset_rooftop':
      case 'sunset_rooftop_hoi_an':
        return const _PostDetailSeed(
          authorName: 'Sarah Johnson',
          username: '@sarahjohnson',
          timeLabel: '5h ago',
          visibilityLabel: 'PUBLIC',
          avatarPath: 'assets/images/profile.jpg',
          caption:
              'Golden hour hits differently up here. The skyline, mocktails, and open-air seating are worth planning your evening around.',
          tags: <String>['sunset', 'rooftop', 'views'],
          socialLabel: 'With Daniel and 2 others',
        );
      case 'art_gallery':
      case 'art_gallery_hoi_an':
        return const _PostDetailSeed(
          authorName: 'Sarah Johnson',
          username: '@sarahjohnson',
          timeLabel: '1d ago',
          visibilityLabel: 'PUBLIC',
          avatarPath: 'assets/images/profile.jpg',
          caption:
              'A calm creative corner with sketchbooks, soft music, and desserts that actually live up to the display case.',
          tags: <String>['artsy', 'quiet', 'dessert'],
          socialLabel: 'With Linh and 1 other',
        );
      default:
        return const _PostDetailSeed(
          authorName: 'Sarah Johnson',
          username: '@sarahjohnson',
          timeLabel: '2h ago',
          visibilityLabel: 'PUBLIC',
          avatarPath: 'assets/images/profile.jpg',
          caption:
              'Finding peace at this minimalist cafe. The matcha latte is a must-try and the space is perfect for reading or quiet work sessions.',
          tags: <String>['cozy', 'quiet', 'minimalist'],
          socialLabel: 'With Sarah and 2 others',
        );
    }
  }
}
