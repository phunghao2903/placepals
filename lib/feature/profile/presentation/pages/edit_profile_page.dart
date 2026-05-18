import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/core.dart';
import '../../domain/entities/current_user_profile.dart';
import '../../domain/entities/update_current_user_profile_input.dart';
import '../../domain/repositories/current_user_profile_repository.dart';

const Color _editProfileCanvas = Color(0xFFFFFAF8);
const Color _editProfileStroke = Color(0xFFF3E8E5);
const Color _editProfileAccent = Color(0xFFFF6B5A);
const Color _editProfileSuccess = Color(0xFF22C55E);

enum _ProfileMediaTarget { avatar, cover }

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static const int _bioLimit = 150;
  static final RegExp _usernamePattern = RegExp(r'^[a-z0-9._]{3,20}$');
  static final RegExp _phonePattern = RegExp(r'^[+\d\s\-()]{8,20}$');

  final CurrentUserProfileRepository _profileRepository =
      getIt<CurrentUserProfileRepository>();
  final ImagePicker _imagePicker = ImagePicker();

  late final TextEditingController _displayNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  CurrentUserProfile? _currentProfile;
  Uint8List? _avatarBytes;
  Uint8List? _coverBytes;
  String? _avatarContentType;
  String? _coverContentType;
  String? _displayNameError;
  String? _usernameError;
  String? _phoneError;
  String? _generalError;
  String? _loadError;
  bool _clearAvatar = false;
  bool _clearCover = false;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _usernameController = TextEditingController();
    _bioController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();

    _displayNameController.addListener(_refresh);
    _usernameController.addListener(_refresh);
    _bioController.addListener(_refresh);
    _phoneController.addListener(_refresh);

    _loadProfile();
  }

  @override
  void dispose() {
    _displayNameController
      ..removeListener(_refresh)
      ..dispose();
    _usernameController
      ..removeListener(_refresh)
      ..dispose();
    _bioController
      ..removeListener(_refresh)
      ..dispose();
    _emailController.dispose();
    _phoneController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    try {
      final profile = await _profileRepository.getCurrentUserProfile();
      if (!mounted) {
        return;
      }

      _currentProfile = profile;
      _displayNameController.text = profile.displayName;
      _usernameController.text = profile.username;
      _bioController.text = profile.bio;
      _emailController.text = profile.email;
      _phoneController.text = profile.phoneNumber ?? '';
    } catch (error) {
      if (!mounted) {
        return;
      }

      _loadError = error is Exception
          ? error.toString().replaceFirst('Exception: ', '')
          : 'Unable to load your profile.';
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: _editProfileCanvas,
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(color: _editProfileAccent),
          ),
        ),
      );
    }

    if (_loadError != null) {
      return Scaffold(
        backgroundColor: _editProfileCanvas,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _loadError!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: _loadProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _editProfileAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final bioLength = _bioController.text.characters.length;
    final avatarImagePath = _clearAvatar
        ? null
        : _currentProfile?.avatarUrl ?? 'assets/images/profile.jpg';
    final coverImagePath = _clearCover ? null : _currentProfile?.coverUrl;

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
                onBack: _isSaving ? () {} : () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 18),
              _ProfileHeroCard(
                avatarImagePath: avatarImagePath,
                avatarBytes: _avatarBytes,
                coverImagePath: coverImagePath,
                coverBytes: _coverBytes,
                onEditAvatar: () =>
                    _showMediaOptions(_ProfileMediaTarget.avatar),
                onEditCover: () => _showMediaOptions(_ProfileMediaTarget.cover),
              ),
              const SizedBox(height: 18),
              _ProfileInputField(
                label: 'Display Name',
                icon: Icons.person_outline_rounded,
                controller: _displayNameController,
                textInputAction: TextInputAction.next,
                errorText: _displayNameError,
              ),
              const SizedBox(height: 12),
              _ProfileInputField(
                label: 'Username',
                icon: Icons.alternate_email_rounded,
                controller: _usernameController,
                textInputAction: TextInputAction.next,
                helperText: 'Your profile will be available at placepals.com/',
                trailingText: '@',
                errorText: _usernameError,
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
                readOnly: true,
                showSuccessIndicator: false,
              ),
              const SizedBox(height: 12),
              _ProfileInputField(
                label: 'Phone Number',
                optionalLabel: '(Optional)',
                icon: Icons.phone_outlined,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                errorText: _phoneError,
              ),
              const SizedBox(height: 14),
              const _PrivacyNoteCard(),
              if (_generalError != null) ...<Widget>[
                const SizedBox(height: 14),
                Text(
                  _generalError!,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.error,
                    fontSize: 11,
                  ),
                ),
              ],
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSaving ? null : _saveChanges,
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
                  label: _isSaving
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withValues(alpha: 0.95),
                            ),
                          ),
                        )
                      : Text(
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
                  onPressed: _isSaving
                      ? null
                      : () => Navigator.of(context).pop(),
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

  Future<void> _showMediaOptions(_ProfileMediaTarget target) async {
    final hasCurrentImage = switch (target) {
      _ProfileMediaTarget.avatar =>
        _avatarBytes != null ||
            (!_clearAvatar && _currentProfile?.avatarUrl != null),
      _ProfileMediaTarget.cover =>
        _coverBytes != null ||
            (!_clearCover && _currentProfile?.coverUrl != null),
    };

    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _pickImage(target, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _pickImage(target, ImageSource.camera);
                },
              ),
              if (hasCurrentImage)
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.error,
                  ),
                  title: const Text('Remove current image'),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _removeImage(target);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(
    _ProfileMediaTarget target,
    ImageSource source,
  ) async {
    if (source == ImageSource.gallery) {
      await _pickGalleryImage(target);
      return;
    }

    await _pickCameraImage(target);
  }

  Future<void> _pickGalleryImage(_ProfileMediaTarget target) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      final file = result?.files.singleOrNull;
      final bytes = file?.bytes;
      if (file == null || bytes == null || bytes.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No image was selected. If you are using the emulator, add a photo to the emulator first.',
              ),
            ),
          );
        }
        return;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        if (target == _ProfileMediaTarget.avatar) {
          _avatarBytes = bytes;
          _avatarContentType = file.extension == 'png'
              ? 'image/png'
              : 'image/jpeg';
          _clearAvatar = false;
        } else {
          _coverBytes = bytes;
          _coverContentType = file.extension == 'png'
              ? 'image/png'
              : 'image/jpeg';
          _clearCover = false;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image selected. Tap Save Changes to upload it.'),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unable to open gallery: $error')));
    }
  }

  Future<void> _pickCameraImage(_ProfileMediaTarget target) async {
    try {
      final file = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1800,
      );
      if (file == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Camera did not return an image. On the emulator, camera support can be limited.',
              ),
            ),
          );
        }
        return;
      }

      final bytes = await file.readAsBytes();
      if (!mounted) {
        return;
      }

      setState(() {
        if (target == _ProfileMediaTarget.avatar) {
          _avatarBytes = bytes;
          _avatarContentType = file.mimeType;
          _clearAvatar = false;
        } else {
          _coverBytes = bytes;
          _coverContentType = file.mimeType;
          _clearCover = false;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image selected. Tap Save Changes to upload it.'),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unable to open camera: $error')));
    }
  }

  void _removeImage(_ProfileMediaTarget target) {
    setState(() {
      if (target == _ProfileMediaTarget.avatar) {
        _avatarBytes = null;
        _avatarContentType = null;
        _clearAvatar = true;
      } else {
        _coverBytes = null;
        _coverContentType = null;
        _clearCover = true;
      }
    });
  }

  Future<void> _saveChanges() async {
    if (!_validateForm()) {
      return;
    }

    setState(() {
      _isSaving = true;
      _generalError = null;
    });

    try {
      final phoneNumber = _phoneController.text.trim();
      await _profileRepository.updateCurrentUserProfile(
        UpdateCurrentUserProfileInput(
          displayName: _displayNameController.text.trim(),
          username: _normalizeUsername(_usernameController.text),
          bio: _bioController.text.trim(),
          phoneNumber: phoneNumber.isEmpty ? null : phoneNumber,
          avatarBytes: _avatarBytes,
          avatarContentType: _avatarContentType,
          coverBytes: _coverBytes,
          coverContentType: _coverContentType,
          clearAvatar: _clearAvatar,
          clearCover: _clearCover,
        ),
      );

      if (!mounted) {
        return;
      }

      await _showSuccessDialog();

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (error) {
      final message = error is Exception
          ? error.toString().replaceFirst('Exception: ', '')
          : 'Unable to save your profile right now.';
      setState(() {
        if (message == 'Username is already taken.') {
          _usernameError = message;
        } else {
          _generalError = message;
        }
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  bool _validateForm() {
    final displayName = _displayNameController.text.trim();
    final normalizedUsername = _normalizeUsername(_usernameController.text);
    final phoneNumber = _phoneController.text.trim();
    final bioLength = _bioController.text.characters.length;

    setState(() {
      _displayNameError = null;
      _usernameError = null;
      _phoneError = null;
      _generalError = null;
    });

    if (displayName.isEmpty) {
      _displayNameError = 'Display name is required.';
    }

    if (_usernameController.text.trim().isEmpty) {
      _usernameError = 'Username is required.';
    } else if (!_usernamePattern.hasMatch(normalizedUsername)) {
      _usernameError = 'Use 3-20 lowercase letters, numbers, "." or "_".';
    } else if (_usernameController.text != normalizedUsername) {
      _usernameController.value = _usernameController.value.copyWith(
        text: normalizedUsername,
        selection: TextSelection.collapsed(offset: normalizedUsername.length),
      );
    }

    if (bioLength > _bioLimit) {
      _generalError = 'Bio must be 150 characters or fewer.';
    }

    if (phoneNumber.isNotEmpty && !_phonePattern.hasMatch(phoneNumber)) {
      _phoneError = 'Enter a valid phone number or leave it empty.';
    }

    setState(() {});

    return _displayNameError == null &&
        _usernameError == null &&
        _phoneError == null &&
        _generalError == null;
  }

  String _normalizeUsername(String value) {
    return value.trim().toLowerCase().replaceAll('@', '');
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
      transitionBuilder: (context, animation, secondaryAnimation, child) {
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

  const _EditProfileHeader({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CircleButton(icon: Icons.arrow_back_ios_new_rounded, onTap: onBack),
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
  final String? avatarImagePath;
  final Uint8List? avatarBytes;
  final String? coverImagePath;
  final Uint8List? coverBytes;
  final VoidCallback onEditAvatar;
  final VoidCallback onEditCover;

  const _ProfileHeroCard({
    required this.avatarImagePath,
    required this.avatarBytes,
    required this.coverImagePath,
    required this.coverBytes,
    required this.onEditAvatar,
    required this.onEditCover,
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
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: SizedBox(
                  height: 116,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if (coverBytes != null || coverImagePath != null)
                        _AdaptiveProfileImage(
                          imagePath: coverImagePath,
                          bytes: coverBytes,
                          fit: BoxFit.cover,
                          fallback: Container(
                            decoration: const BoxDecoration(
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
                          ),
                        )
                      else
                        Container(
                          decoration: const BoxDecoration(
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
                        ),
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
                            onTap: onEditCover,
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
                        child: _AdaptiveProfileImage(
                          imagePath: avatarImagePath,
                          bytes: avatarBytes,
                          fit: BoxFit.cover,
                          fallback: Image.asset(
                            'assets/images/profile.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
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

class _AdaptiveProfileImage extends StatelessWidget {
  final String? imagePath;
  final Uint8List? bytes;
  final BoxFit fit;
  final Widget fallback;

  const _AdaptiveProfileImage({
    required this.imagePath,
    required this.bytes,
    required this.fit,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    if (bytes != null) {
      return Image.memory(bytes!, fit: fit);
    }

    if (imagePath == null || imagePath!.isEmpty) {
      return fallback;
    }

    if (imagePath!.startsWith('http://') || imagePath!.startsWith('https://')) {
      return Image.network(
        imagePath!,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => fallback,
      );
    }

    return Image.asset(imagePath!, fit: fit);
  }
}

class _ProfileInputField extends StatelessWidget {
  final String label;
  final String? optionalLabel;
  final String? helperText;
  final String? trailingText;
  final String? errorText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool showSuccessIndicator;

  const _ProfileInputField({
    required this.label,
    required this.icon,
    required this.controller,
    this.optionalLabel,
    this.helperText,
    this.trailingText,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.readOnly = false,
    this.showSuccessIndicator = true,
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
          readOnly: readOnly,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: readOnly
                ? const Color(0xFFF1ECEB)
                : const Color(0xFFF6F1F0),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: errorText != null ? AppColors.error : Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: errorText != null ? AppColors.error : _editProfileAccent,
              ),
            ),
            suffixIcon: (trailingText != null || showSuccessIndicator)
                ? Padding(
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
                        if (showSuccessIndicator)
                          const Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: _editProfileSuccess,
                          ),
                      ],
                    ),
                  )
                : null,
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
        if (errorText != null) ...<Widget>[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.error,
              fontSize: 10,
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
              borderSide: BorderSide(
                color: isOverflow ? AppColors.error : Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isOverflow ? AppColors.error : _editProfileAccent,
              ),
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
      constraints: const BoxConstraints(maxWidth: 330, minHeight: 250),
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
            border: Border.all(color: _editProfileStroke),
          ),
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
