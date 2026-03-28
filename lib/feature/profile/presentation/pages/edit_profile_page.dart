import 'package:flutter/material.dart';

import '../../../../core/core.dart';

const Color _editProfileCanvas = Color(0xFFFFFAF8);
const Color _editProfileStroke = Color(0xFFF3E8E5);
const Color _editProfileAccent = Color(0xFFFF6B5A);
const Color _editProfileSuccess = Color(0xFF22C55E);

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static const int _bioLimit = 150;

  late final TextEditingController _displayNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController(text: 'Sarah Johnson');
    _usernameController = TextEditingController(text: 'sarahjohnson');
    _bioController = TextEditingController();
    _emailController = TextEditingController(text: 'sarah.j@example.com');
    _phoneController = TextEditingController(text: '+84 123 456 700');
    _bioController.addListener(_refresh);
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _bioController
      ..removeListener(_refresh)
      ..dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bioLength = _bioController.text.characters.length;

    return Scaffold(
      backgroundColor: _editProfileCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _EditProfileHeader(
                title: 'Edit Profile',
                onBack: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 18),
              _ProfileHeroCard(
                imagePath: 'assets/images/profile.jpg',
                onEditAvatar: _showAvatarEditorStub,
              ),
              const SizedBox(height: 18),
              _ProfileInputField(
                label: 'Display Name',
                icon: Icons.person_outline_rounded,
                controller: _displayNameController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              _ProfileInputField(
                label: 'Username',
                icon: Icons.alternate_email_rounded,
                controller: _usernameController,
                textInputAction: TextInputAction.next,
                helperText: 'Your profile will be available at placepals.com/',
                trailingText: '@',
              ),
              const SizedBox(height: 12),
              _BioInputField(
                controller: _bioController,
                currentLength: bioLength,
                maxLength: _bioLimit,
              ),
              const SizedBox(height: 12),
              _ProfileInputField(
                label: 'Email',
                icon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              _ProfileInputField(
                label: 'Phone Number',
                optionalLabel: '(Optional)',
                icon: Icons.phone_outlined,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 14),
              const _PrivacyNoteCard(),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    elevation: 0,
                    backgroundColor: _editProfileAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  icon: const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Save Changes',
                    style: AppTextStyles.body2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAvatarEditorStub() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Avatar editing is not implemented yet.')),
    );
  }

  Future<void> _saveChanges() async {
    if (_displayNameController.text.trim().isEmpty ||
        _usernameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the required fields.')),
      );
      return;
    }

    if (_bioController.text.characters.length > _bioLimit) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bio is too long.')),
      );
      return;
    }

    await _showSuccessDialog();

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _showSuccessDialog() async {
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Profile updated',
      barrierColor: const Color(0x66000000),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 1200));
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });

        return const SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: _ProfileUpdatedDialog(),
            ),
          ),
        );
      },
      transitionBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }
}

class _EditProfileHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _EditProfileHeader({
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CircleButton(
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

class _ProfileHeroCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onEditAvatar;

  const _ProfileHeroCard({
    required this.imagePath,
    required this.onEditAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _editProfileStroke),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14111827),
            blurRadius: 24,
            offset: Offset(0, 16),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                height: 116,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFFF4E7E2),
                      Color(0xFFFF8A7B),
                      _editProfileAccent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: -18,
                      top: 12,
                      child: Container(
                        width: 120,
                        height: 58,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -12,
                      bottom: -10,
                      child: Container(
                        width: 156,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 14,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: onEditAvatar,
                          child: const SizedBox(
                            width: 32,
                            height: 32,
                            child: Icon(
                              Icons.photo_camera_outlined,
                              size: 16,
                              color: _editProfileAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16,
                bottom: -34,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x1F111827),
                            blurRadius: 20,
                            offset: Offset(0, 12),
                            spreadRadius: -12,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(imagePath, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Material(
                        color: _editProfileAccent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: onEditAvatar,
                          child: Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.photo_camera_outlined,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 46),
        ],
      ),
    );
  }
}

class _ProfileInputField extends StatelessWidget {
  final String label;
  final String? optionalLabel;
  final String? helperText;
  final String? trailingText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const _ProfileInputField({
    required this.label,
    required this.icon,
    required this.controller,
    this.optionalLabel,
    this.helperText,
    this.trailingText,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 13, color: _editProfileAccent),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
            if (optionalLabel != null) ...<Widget>[
              const SizedBox(width: 4),
              Text(
                optionalLabel!,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF6F1F0),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: _editProfileAccent),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (trailingText != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        trailingText!,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: _editProfileSuccess,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (helperText != null) ...<Widget>[
          const SizedBox(height: 6),
          Text(
            helperText!,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
              height: 1.35,
            ),
          ),
        ],
      ],
    );
  }
}

class _BioInputField extends StatelessWidget {
  final TextEditingController controller;
  final int currentLength;
  final int maxLength;

  const _BioInputField({
    required this.controller,
    required this.currentLength,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final isOverflow = currentLength > maxLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Bio',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 4,
          textInputAction: TextInputAction.newline,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: 'Tell us about yourself...',
            hintStyle: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: const Color(0xFFF6F1F0),
            contentPadding: const EdgeInsets.all(14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: _editProfileAccent),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Add emojis to make your bio stand out',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ),
            Text(
              '$currentLength/$maxLength',
              style: AppTextStyles.caption.copyWith(
                color: isOverflow ? AppColors.error : AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PrivacyNoteCard extends StatelessWidget {
  const _PrivacyNoteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7F5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF2D5CE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Privacy Note',
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your email and phone number are private and will not be shown on your public profile. We only use them for account security and important notifications.',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileUpdatedDialog extends StatelessWidget {
  const _ProfileUpdatedDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 330,
        minHeight: 250,
      ),
      padding: const EdgeInsets.fromLTRB(28, 34, 28, 34),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x30111827),
            blurRadius: 44,
            offset: Offset(0, 20),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 96,
            height: 96,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _editProfileSuccess,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 52,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Profile Updated!',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading4.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              decoration: TextDecoration.none,
              decorationColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: Text(
              'Your profile has been\nsuccessfully updated.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body1.copyWith(
                color: const Color(0xFF546179),
                fontSize: 16,
                height: 1.35,
                decoration: TextDecoration.none,
                decorationColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

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
            border: Border.all(color: _editProfileStroke),
          ),
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
