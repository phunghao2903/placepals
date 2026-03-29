import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../../core/firebase/push_notification_service.dart';
import '../../../signup_signin/presentation/pages/splash_page.dart';
import 'change_password_page.dart';
import 'edit_profile_page.dart';
import 'profile_privacy_page.dart';

const Color _profileSettingsCanvas = Color(0xFFFFFAF8);
const Color _profileSettingsStroke = Color(0xFFF3E8E5);
const Color _profileSettingsAccent = Color(0xFFFF6B5A);

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final Map<String, bool> _toggles = <String, bool>{
    'public_profile': true,
    'show_location': true,
    'push_notifications': true,
    'email_notifications': true,
    'likes_on_places': true,
    'comments_on_places': true,
    'new_followers': true,
    'dark_mode': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _profileSettingsCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _SettingsHeader(
                title: 'Settings',
                onBack: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 18),
              _buildAccountSection(),
              const SizedBox(height: 18),
              _buildPrivacySection(),
              const SizedBox(height: 18),
              _buildNotificationSection(),
              const SizedBox(height: 18),
              _buildNotifySection(),
              const SizedBox(height: 18),
              _buildAppearanceSection(),
              const SizedBox(height: 18),
              _buildSupportSection(),
              const SizedBox(height: 18),
              _buildDangerSection(),
              const SizedBox(height: 22),
              Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'PlacePals v1.0.0',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Made with love for sharing amazing places',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(label: 'Account'),
        const SizedBox(height: 10),
        _SettingsCard(
          child: Column(
            children: <Widget>[
              _SettingsTile(
                icon: Icons.person_outline_rounded,
                iconBackground: const Color(0xFFFFEBE6),
                iconColor: const Color(0xFFFF7A66),
                title: 'Edit Profile',
                subtitle: 'Update your personal information',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const EditProfilePage(),
                    ),
                  );
                },
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.lock_outline_rounded,
                iconBackground: const Color(0xFFFFF2E3),
                iconColor: const Color(0xFFFFA31A),
                title: 'Change Password',
                subtitle: 'Update your password',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ChangePasswordPage(),
                    ),
                  );
                },
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.email_outlined,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                title: 'Email Address',
                subtitle: 'sarah@example.com',
                onTap: _showNotImplemented,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(label: 'Privacy & Security'),
        const SizedBox(height: 10),
        _SettingsCard(
          child: Column(
            children: <Widget>[
              _SettingsSwitchTile(
                icon: Icons.public_rounded,
                iconBackground: const Color(0xFFE8FAEC),
                iconColor: const Color(0xFF22C55E),
                title: 'Public Profile',
                subtitle: 'Anyone can see your profile',
                value: _toggles['public_profile']!,
                onChanged: (value) => _setToggle('public_profile', value),
              ),
              const _CardDivider(),
              _SettingsSwitchTile(
                icon: Icons.location_on_outlined,
                iconBackground: const Color(0xFFFFF4E7),
                iconColor: const Color(0xFFF59E0B),
                title: 'Show Location',
                subtitle: 'Display city on places',
                value: _toggles['show_location']!,
                onChanged: (value) => _setToggle('show_location', value),
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.block_outlined,
                iconBackground: const Color(0xFFFFECE8),
                iconColor: const Color(0xFFE25B4C),
                title: 'Blocked Users',
                subtitle: 'Manage blocked accounts',
                onTap: _showNotImplemented,
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.storage_outlined,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                title: 'Data & Privacy',
                subtitle: 'Download or delete your data',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ProfilePrivacyPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(label: 'Notifications'),
        const SizedBox(height: 10),
        _SettingsCard(
          child: Column(
            children: <Widget>[
              _SettingsSwitchTile(
                icon: Icons.notifications_none_rounded,
                iconBackground: const Color(0xFFFFECE8),
                iconColor: const Color(0xFFFF7A66),
                title: 'Push Notifications',
                subtitle: 'Receive push alerts',
                value: _toggles['push_notifications']!,
                onChanged: (value) => _setToggle('push_notifications', value),
              ),
              const _CardDivider(),
              _SettingsSwitchTile(
                icon: Icons.email_outlined,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                title: 'Email Notifications',
                subtitle: 'Receive email updates',
                value: _toggles['email_notifications']!,
                onChanged: (value) => _setToggle('email_notifications', value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotifySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(label: 'Notify Me About'),
        const SizedBox(height: 10),
        _SettingsCard(
          child: Column(
            children: <Widget>[
              _SettingsSwitchTile(
                icon: Icons.favorite_border_rounded,
                iconBackground: const Color(0xFFFFECE8),
                iconColor: const Color(0xFFFF7A66),
                title: 'Likes on my places',
                subtitle: 'Get notified when someone likes your post',
                value: _toggles['likes_on_places']!,
                onChanged: (value) => _setToggle('likes_on_places', value),
              ),
              const _CardDivider(),
              _SettingsSwitchTile(
                icon: Icons.chat_bubble_outline_rounded,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                title: 'Comments on my places',
                subtitle: 'Get notified about new comments',
                value: _toggles['comments_on_places']!,
                onChanged: (value) => _setToggle('comments_on_places', value),
              ),
              const _CardDivider(),
              _SettingsSwitchTile(
                icon: Icons.person_add_alt_1_rounded,
                iconBackground: const Color(0xFFFFF2E3),
                iconColor: const Color(0xFFF59E0B),
                title: 'New followers',
                subtitle: 'Know when someone follows you',
                value: _toggles['new_followers']!,
                onChanged: (value) => _setToggle('new_followers', value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppearanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(label: 'Appearance'),
        const SizedBox(height: 10),
        _SettingsCard(
          child: Column(
            children: <Widget>[
              _SettingsSwitchTile(
                icon: Icons.dark_mode_outlined,
                iconBackground: const Color(0xFF2D2D2D),
                iconColor: Colors.white,
                title: 'Dark Mode',
                subtitle: 'Switch to dark theme',
                value: _toggles['dark_mode']!,
                onChanged: (value) => _setToggle('dark_mode', value),
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.palette_outlined,
                iconBackground: const Color(0xFFFFECE8),
                iconColor: const Color(0xFFFF7A66),
                title: 'Theme Color',
                subtitle: 'Coral (default)',
                onTap: _showNotImplemented,
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.language_rounded,
                iconBackground: const Color(0xFFE8FAEC),
                iconColor: const Color(0xFF22C55E),
                title: 'Language',
                subtitle: 'Tiếng Việt',
                onTap: _showNotImplemented,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(label: 'Support & About'),
        const SizedBox(height: 10),
        _SettingsCard(
          child: Column(
            children: <Widget>[
              _SettingsTile(
                icon: Icons.help_outline_rounded,
                iconBackground: const Color(0xFFFFF2E3),
                iconColor: const Color(0xFFF59E0B),
                title: 'Help Center',
                subtitle: 'FAQs and guides',
                onTap: _showNotImplemented,
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.support_agent_rounded,
                iconBackground: const Color(0xFFE8FAEC),
                iconColor: const Color(0xFF22C55E),
                title: 'Contact Support',
                subtitle: 'Get help from our team',
                onTap: _showNotImplemented,
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.report_problem_outlined,
                iconBackground: const Color(0xFFFFF2E3),
                iconColor: const Color(0xFFF59E0B),
                title: 'Report a Problem',
                subtitle: 'Let us know about issues',
                onTap: _showNotImplemented,
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.description_outlined,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                title: 'Terms of Service',
                subtitle: 'Read our terms',
                onTap: _showNotImplemented,
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                iconBackground: const Color(0xFFEAF2FF),
                iconColor: const Color(0xFF4A7CFF),
                title: 'Privacy Policy',
                subtitle: 'How we handle your data',
                onTap: _showNotImplemented,
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                iconBackground: const Color(0xFFFFF2E3),
                iconColor: const Color(0xFFF59E0B),
                title: 'About PlacePals',
                subtitle: 'Version 1.0.0',
                onTap: _showNotImplemented,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDangerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionLabel(
          label: 'Danger Zone',
          color: Color(0xFFE25B4C),
        ),
        const SizedBox(height: 10),
        _SettingsCard(
          child: Column(
            children: <Widget>[
              _SettingsTile(
                icon: Icons.logout_rounded,
                iconBackground: const Color(0xFFFFF2E3),
                iconColor: const Color(0xFFF59E0B),
                title: 'Log Out',
                subtitle: 'Sign out from your account',
                onTap: _showLogoutDialog,
              ),
              const _CardDivider(),
              _SettingsTile(
                icon: Icons.delete_outline_rounded,
                iconBackground: const Color(0xFFFFECE8),
                iconColor: const Color(0xFFFF7A66),
                title: 'Delete Account',
                subtitle: 'Permanently delete your account',
                onTap: _showNotImplemented,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _setToggle(String key, bool value) {
    setState(() {
      _toggles[key] = value;
    });
  }

  void _showNotImplemented() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This setting is not implemented yet.')),
    );
  }

  Future<void> _showLogoutDialog() async {
    await showDialog<void>(
      context: context,
      barrierColor: const Color(0x73000000),
      builder: (dialogContext) {
        return _LogoutDialog(
          onCancel: () => Navigator.of(dialogContext).pop(),
          onConfirm: () {
            Navigator.of(dialogContext).pop();
            _handleLogout();
          },
        );
      },
    );
  }

  Future<void> _handleLogout() async {
    try {
      try {
        await getIt<PushNotificationService>()
            .detachCurrentTokenFromCurrentUser();
      } catch (_) {}
      await getIt<FirebaseAuthService>().signOut();
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (_) => const SplashPage(showWhatsNewOnComplete: false),
        ),
        (route) => false,
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to sign out right now. Please try again.'),
        ),
      );
    }
  }
}

class _SettingsHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _SettingsHeader({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CircleActionButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
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

class _SectionLabel extends StatelessWidget {
  final String label;
  final Color color;

  const _SectionLabel({
    required this.label,
    this.color = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: AppTextStyles.caption.copyWith(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;

  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF3E8E5)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14111827),
            blurRadius: 18,
            offset: Offset(0, 12),
            spreadRadius: -14,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
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
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: <Widget>[
              _LeadingIcon(
                icon: icon,
                background: iconBackground,
                color: iconColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
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
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchTile({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: <Widget>[
          _LeadingIcon(
            icon: icon,
            background: iconBackground,
            color: iconColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.88,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFFFF6B5A),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFE9DEDB),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color color;

  const _LeadingIcon({
    required this.icon,
    required this.background,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, size: 15, color: color),
    );
  }
}

class _CardDivider extends StatelessWidget {
  const _CardDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF3E8E5));
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleActionButton({required this.icon, required this.onTap});

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
            border: Border.all(color: _profileSettingsStroke),
          ),
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const _LogoutDialog({
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        width: 320,
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 28,
              offset: Offset(0, 20),
              spreadRadius: -18,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF1EE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                size: 20,
                color: Color(0xFFFF6B5A),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Log Out?',
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to log out from your account?',
              textAlign: TextAlign.center,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(44),
                      side: const BorderSide(color: Color(0xFFF3E8E5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(44),
                      elevation: 0,
                      backgroundColor: _profileSettingsAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
