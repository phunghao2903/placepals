class CurrentUserProfile {
  final String uid;
  final String displayName;
  final String username;
  final String bio;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? coverUrl;
  final DateTime? createdAt;

  const CurrentUserProfile({
    required this.uid,
    required this.displayName,
    required this.username,
    required this.bio,
    required this.email,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.coverUrl,
    required this.createdAt,
  });

  CurrentUserProfile copyWith({
    String? uid,
    String? displayName,
    String? username,
    String? bio,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    String? coverUrl,
    DateTime? createdAt,
  }) {
    return CurrentUserProfile(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
