import 'package:flutter/material.dart';

import '../../../../core/core.dart';

const Color _privacyCanvas = Color(0xFFFFFAF8);
const Color _privacyStroke = Color(0xFFF3E8E5);
const Color _privacyAccent = Color(0xFFFF6B5A);
const Color _privacyAccentDark = Color(0xFFE25B4C);

class ProfilePrivacyPage extends StatefulWidget {
  const ProfilePrivacyPage({super.key});

  @override
  State<ProfilePrivacyPage> createState() => _ProfilePrivacyPageState();
}

class _ProfilePrivacyPageState extends State<ProfilePrivacyPage> {
  final Map<String, bool> _toggles = <String, bool>{
    'private_account': false,
    'show_saved_places': true,
    'show_activity_status': true,
    'followers_only_messages': true,
    'tag_review': true,
    'share_precise_location': false,
    'search_indexing': false,
    'personalized_recommendations': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _privacyCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _PrivacyHeader(onBack: () => Navigator.of(context).pop()),
              const SizedBox(height: 18),
              _PrivacyHeroPanel(
                profileMode: _toggles['private_account']!
                    ? 'Private profile'
                    : 'Public profile',
                chips: <String>[
                  _toggles['tag_review']! ? 'Tag review on' : 'Tag review off',
                  _toggles['followers_only_messages']!
                      ? 'Follower inbox'
                      : 'Open inbox',
                  _toggles['share_precise_location']!
                      ? 'Precise location'
                      : 'Approximate location',
                ],
              ),
              const SizedBox(height: 18),
              _PrivacySectionTitle(
                label: 'Profile Mode',
                subtitle: 'Choose how open your account feels.',
              ),
              const SizedBox(height: 10),
              _ProfileModeSelector(
                isPrivate: _toggles['private_account']!,
                onChanged: (value) => _setToggle('private_account', value),
              ),
              const SizedBox(height: 18),
              _PrivacySectionTitle(
                label: 'Visibility Controls',
                subtitle: 'Manage what people can actually see.',
              ),
              const SizedBox(height: 10),
              _PrivacyTogglePanel(
                icon: Icons.bookmark_outline_rounded,
                iconBackground: const Color(0xFFFFF2E8),
                iconColor: const Color(0xFFF59E0B),
                eyebrow: 'Collection',
                title: 'Saved Places Visibility',
                description:
                    'Show or hide the saved places collection on your public profile.',
                valueLabel: _toggles['show_saved_places']! ? 'Visible' : 'Hidden',
                value: _toggles['show_saved_places']!,
                onChanged: (value) => _setToggle('show_saved_places', value),
              ),
              const SizedBox(height: 12),
              _PrivacyTogglePanel(
                icon: Icons.bolt_outlined,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                eyebrow: 'Presence',
                title: 'Activity Status',
                description:
                    'Let followers know when you were recently active in PlacePals.',
                valueLabel:
                    _toggles['show_activity_status']! ? 'Shared' : 'Hidden',
                value: _toggles['show_activity_status']!,
                onChanged: (value) => _setToggle('show_activity_status', value),
              ),
              const SizedBox(height: 12),
              _PrivacyTogglePanel(
                icon: Icons.location_on_outlined,
                iconBackground: const Color(0xFFFFF2E8),
                iconColor: const Color(0xFFF59E0B),
                eyebrow: 'Location',
                title: 'Precise Location Sharing',
                description:
                    'Use exact location when posting a place instead of a broader city label.',
                valueLabel: _toggles['share_precise_location']!
                    ? 'Precise'
                    : 'Approximate',
                value: _toggles['share_precise_location']!,
                onChanged: (value) =>
                    _setToggle('share_precise_location', value),
              ),
              const SizedBox(height: 18),
              _PrivacySectionTitle(
                label: 'Messages & Tags',
                subtitle: 'Reduce spam and control how you appear.',
              ),
              const SizedBox(height: 10),
              _PrivacyTogglePanel(
                icon: Icons.mail_outline_rounded,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                eyebrow: 'Inbox',
                title: 'Followers-Only Messages',
                description:
                    'Accept new direct messages only from people who already follow you.',
                valueLabel: _toggles['followers_only_messages']!
                    ? 'Filtered'
                    : 'Open',
                value: _toggles['followers_only_messages']!,
                onChanged: (value) =>
                    _setToggle('followers_only_messages', value),
              ),
              const SizedBox(height: 12),
              _PrivacyTogglePanel(
                icon: Icons.local_offer_outlined,
                iconBackground: const Color(0xFFE8FAEC),
                iconColor: const Color(0xFF22C55E),
                eyebrow: 'Mentions',
                title: 'Review Tags Before Posting',
                description:
                    'Approve mentions before they show up on your profile and activity.',
                valueLabel: _toggles['tag_review']! ? 'Manual review' : 'Auto allow',
                value: _toggles['tag_review']!,
                onChanged: (value) => _setToggle('tag_review', value),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _PrivacyActionCard(
                      icon: Icons.block_outlined,
                      iconBackground: const Color(0xFFFFECE8),
                      iconColor: _privacyAccentDark,
                      title: 'Blocked Users',
                      subtitle: '3 accounts',
                      onTap: () => _showMessage(
                        'Blocked users manager is not implemented yet.',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _PrivacyActionCard(
                      icon: Icons.group_outlined,
                      iconBackground: const Color(0xFFFFF2E8),
                      iconColor: const Color(0xFFF59E0B),
                      title: 'Close Friends',
                      subtitle: '9 people',
                      onTap: () => _showMessage(
                        'Close friends is not implemented yet.',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _PrivacySectionTitle(
                label: 'Data Footprint',
                subtitle: 'Control discovery, personalization, and exports.',
              ),
              const SizedBox(height: 10),
              _PrivacyTogglePanel(
                icon: Icons.travel_explore_rounded,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                eyebrow: 'Discovery',
                title: 'Search Engine Indexing',
                description:
                    'Allow public places to appear in external search engine results.',
                valueLabel:
                    _toggles['search_indexing']! ? 'Discoverable' : 'Private',
                value: _toggles['search_indexing']!,
                onChanged: (value) => _setToggle('search_indexing', value),
              ),
              const SizedBox(height: 12),
              _PrivacyTogglePanel(
                icon: Icons.auto_awesome_outlined,
                iconBackground: const Color(0xFFFFECE8),
                iconColor: _privacyAccent,
                eyebrow: 'Suggestions',
                title: 'Personalized Recommendations',
                description:
                    'Use your activity to improve suggested places, feeds, and people.',
                valueLabel: _toggles['personalized_recommendations']!
                    ? 'Personalized'
                    : 'Generic',
                value: _toggles['personalized_recommendations']!,
                onChanged: (value) =>
                    _setToggle('personalized_recommendations', value),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _PrivacyActionStrip(
                      icon: Icons.download_outlined,
                      title: 'Download My Data',
                      subtitle: 'Export account archive',
                      onTap: () => _showMessage(
                        'A data export request has been prepared.',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _PrivacyActionStrip(
                      icon: Icons.history_toggle_off_rounded,
                      title: 'Clear Search History',
                      subtitle: 'Remove device history',
                      onTap: () => _showMessage(
                        'Search history cleared on this device.',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _PrivacySectionTitle(
                label: 'Safety Shortcuts',
                subtitle: 'Quick access to help and policy references.',
              ),
              const SizedBox(height: 10),
              _PrivacySupportPanel(
                tiles: <_PrivacySupportItem>[
                  _PrivacySupportItem(
                    icon: Icons.shield_outlined,
                    title: 'Privacy Policy',
                    subtitle: 'How PlacePals handles data',
                    accent: const Color(0xFF4A7CFF),
                    background: const Color(0xFFEAF2FF),
                    onTap: () => _showMessage(
                      'Privacy policy is not implemented yet.',
                    ),
                  ),
                  _PrivacySupportItem(
                    icon: Icons.report_problem_outlined,
                    title: 'Report Concern',
                    subtitle: 'Abuse, harassment, impersonation',
                    accent: _privacyAccentDark,
                    background: const Color(0xFFFFECE8),
                    onTap: () => _showMessage(
                      'Privacy support is not implemented yet.',
                    ),
                  ),
                  _PrivacySupportItem(
                    icon: Icons.tips_and_updates_outlined,
                    title: 'Security Tips',
                    subtitle: 'Guides for safer sharing',
                    accent: const Color(0xFFF59E0B),
                    background: const Color(0xFFFFF2E8),
                    onTap: () => _showMessage(
                      'Security tips are not implemented yet.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Center(
                child: Text(
                  'Your privacy choices are saved on this device.',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setToggle(String key, bool value) {
    setState(() {
      _toggles[key] = value;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _PrivacyHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _PrivacyHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _PrivacyCircleButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Privacy',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}

class _PrivacyHeroPanel extends StatelessWidget {
  final String profileMode;
  final List<String> chips;

  const _PrivacyHeroPanel({
    required this.profileMode,
    required this.chips,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFFF7C6C), Color(0xFFFF6959)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14111827),
            blurRadius: 18,
            offset: Offset(0, 14),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.shield_moon_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Privacy Studio',
                      style: AppTextStyles.heading5.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profileMode,
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'A separate workspace for controlling who sees your profile, how people contact you, and how your data is used.',
            style: AppTextStyles.body2.copyWith(
              color: Colors.white.withValues(alpha: 0.94),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips
                .map(
                  (chip) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.14),
                      ),
                    ),
                    child: Text(
                      chip,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class _PrivacySectionTitle extends StatelessWidget {
  final String label;
  final String subtitle;

  const _PrivacySectionTitle({
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ProfileModeSelector extends StatelessWidget {
  final bool isPrivate;
  final ValueChanged<bool> onChanged;

  const _ProfileModeSelector({
    required this.isPrivate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _ModeCard(
            title: 'Public',
            subtitle: 'Profile and places are easier to discover.',
            icon: Icons.public_rounded,
            accent: const Color(0xFF4A7CFF),
            background: const Color(0xFFEAF2FF),
            isSelected: !isPrivate,
            onTap: () => onChanged(false),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModeCard(
            title: 'Private',
            subtitle: 'Followers need approval to view your account.',
            icon: Icons.lock_outline_rounded,
            accent: _privacyAccent,
            background: const Color(0xFFFFECE8),
            isSelected: isPrivate,
            onTap: () => onChanged(true),
          ),
        ),
      ],
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Color background;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.background,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : const Color(0xFFFFFDFC),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isSelected ? accent : _privacyStroke,
              width: isSelected ? 1.4 : 1,
            ),
            boxShadow: isSelected
                ? const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x14111827),
                      blurRadius: 18,
                      offset: Offset(0, 10),
                      spreadRadius: -14,
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppTextStyles.heading6.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? accent : background,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  isSelected ? 'Current mode' : 'Tap to switch',
                  style: AppTextStyles.caption.copyWith(
                    color: isSelected ? Colors.white : accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacyTogglePanel extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String eyebrow;
  final String title;
  final String description;
  final String valueLabel;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PrivacyTogglePanel({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.valueLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _privacyStroke),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14111827),
            blurRadius: 16,
            offset: Offset(0, 10),
            spreadRadius: -14,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      eyebrow.toUpperCase(),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      title,
                      style: AppTextStyles.heading6.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: Colors.white,
                  activeTrackColor: _privacyAccent,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE9DEDB),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5F2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.tune_rounded, size: 16, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  'Current status',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  valueLabel,
                  style: AppTextStyles.caption.copyWith(
                    color: iconColor,
                    fontWeight: FontWeight.w700,
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

class _PrivacyActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PrivacyActionCard({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
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
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _privacyStroke),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacyActionStrip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PrivacyActionStrip({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDFC),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _privacyStroke),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 18, color: _privacyAccent),
              const SizedBox(height: 10),
              Text(
                title,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacySupportPanel extends StatelessWidget {
  final List<_PrivacySupportItem> tiles;

  const _PrivacySupportPanel({required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _privacyStroke),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14111827),
            blurRadius: 16,
            offset: Offset(0, 10),
            spreadRadius: -14,
          ),
        ],
      ),
      child: Column(
        children: List<Widget>.generate(tiles.length, (index) {
          final tile = tiles[index];
          return Column(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: tile.onTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 34,
                          height: 34,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: tile.background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(tile.icon, size: 18, color: tile.accent),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                tile.title,
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                tile.subtitle,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (index != tiles.length - 1)
                const Divider(height: 1, thickness: 1, color: _privacyStroke),
            ],
          );
        }),
      ),
    );
  }
}

class _PrivacySupportItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final Color background;
  final VoidCallback onTap;

  const _PrivacySupportItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.background,
    required this.onTap,
  });
}

class _PrivacyCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _PrivacyCircleButton({required this.icon, required this.onTap});

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
            border: Border.all(color: _privacyStroke),
          ),
          child: Icon(icon, size: 16, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
