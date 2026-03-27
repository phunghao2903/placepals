import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/core.dart';
import '../../domain/entities/create_moment_friend.dart';
import '../bloc/create_moment_bloc.dart';
import '../widgets/create_moment_friend_tile.dart';

class CreateMomentFriendsPage extends StatefulWidget {
  const CreateMomentFriendsPage({super.key});

  @override
  State<CreateMomentFriendsPage> createState() =>
      _CreateMomentFriendsPageState();
}

class _CreateMomentFriendsPageState extends State<CreateMomentFriendsPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: context.read<CreateMomentBloc>().state.friendQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F0),
      body: SafeArea(
        child: BlocBuilder<CreateMomentBloc, CreateMomentState>(
          builder: (context, state) {
            final feed = state.feed;
            if (feed == null) return const SizedBox.shrink();

            final filteredFriends = _filterFriends(
              feed.friends,
              state.friendQuery,
            );
            final selectedFriends = feed.friends
                .where((friend) => state.selectedFriendIds.contains(friend.id))
                .toList(growable: false);

            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.textPrimary,
                                  size: 20,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                feed.tagFriendsTitle,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _FriendsSearchField(
                        controller: _searchController,
                        hintText: feed.friendSearchHint,
                        onChanged: (value) {
                          context.read<CreateMomentBloc>().add(
                            CreateMomentFriendSearchChanged(query: value),
                          );
                        },
                      ),
                      if (selectedFriends.isNotEmpty) ...<Widget>[
                        const SizedBox(height: 16),
                        _SelectedFriendsSummary(friends: selectedFriends),
                      ],
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFCFAFA),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 40,
                          offset: Offset(0, -10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Container(
                          width: 48,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Suggested Friends',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${selectedFriends.length} selected',
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                            itemCount: filteredFriends.length,
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final friend = filteredFriends[index];
                              return CreateMomentFriendTile(
                                friend: friend,
                                isSelected: state.selectedFriendIds.contains(
                                  friend.id,
                                ),
                                onTap: () {
                                  context.read<CreateMomentBloc>().add(
                                    CreateMomentFriendToggled(
                                      friendId: friend.id,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                            child: SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: FilledButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: Text(
                                  'Done',
                                  style: AppTextStyles.heading3.copyWith(
                                    color: SemanticTextColors.onBrand,
                                  ),
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
            );
          },
        ),
      ),
    );
  }

  List<CreateMomentFriend> _filterFriends(
    List<CreateMomentFriend> friends,
    String query,
  ) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return friends;

    return friends
        .where((friend) {
          return friend.name.toLowerCase().contains(normalized) ||
              friend.subtitle.toLowerCase().contains(normalized);
        })
        .toList(growable: false);
  }
}

class _FriendsSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  const _FriendsSearchField({
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class _SelectedFriendsSummary extends StatelessWidget {
  final List<CreateMomentFriend> friends;

  const _SelectedFriendsSummary({required this.friends});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F0EE),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x26FA7E72),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 64,
            height: 30,
            child: Stack(
              children: List<Widget>.generate(
                friends.length.clamp(0, 4),
                (index) => Positioned(
                  left: index * 16,
                  child: _SummaryAvatar(name: friends[index].name),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${friends.length} friends tagged',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'You can update this list anytime.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
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

class _SummaryAvatar extends StatelessWidget {
  final String name;

  const _SummaryAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0])
        .join();
    final palette = <Color>[
      const Color(0xFFFFD8D2),
      const Color(0xFFFFEDCC),
      const Color(0xFFDDEAFE),
      const Color(0xFFE7D9FF),
    ];
    final background = palette[name.length % palette.length];

    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.2),
      ),
      child: Text(
        initials,
        style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}
