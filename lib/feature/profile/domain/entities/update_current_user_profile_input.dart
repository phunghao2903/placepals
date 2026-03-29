import 'dart:typed_data';

class UpdateCurrentUserProfileInput {
  final String displayName;
  final String username;
  final String bio;
  final String? phoneNumber;
  final Uint8List? avatarBytes;
  final String? avatarContentType;
  final Uint8List? coverBytes;
  final String? coverContentType;
  final bool clearAvatar;
  final bool clearCover;

  const UpdateCurrentUserProfileInput({
    required this.displayName,
    required this.username,
    required this.bio,
    required this.phoneNumber,
    this.avatarBytes,
    this.avatarContentType,
    this.coverBytes,
    this.coverContentType,
    this.clearAvatar = false,
    this.clearCover = false,
  });
}
