import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';

class SavedMarkVisitedPage extends StatefulWidget {
  final WishlistPlace place;

  const SavedMarkVisitedPage({super.key, required this.place});

  @override
  State<SavedMarkVisitedPage> createState() => _SavedMarkVisitedPageState();
}

class _SavedMarkVisitedPageState extends State<SavedMarkVisitedPage> {
  late final TextEditingController _noteController;
  int _selectedRating = 0;
  String _visibility = 'Public';

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(
      text: 'Write your experience... How was the atmosphere? What did you order?',
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.close_rounded, size: 24),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Mark as Visited',
                    style: AppTextStyles.heading5.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Text(
                      widget.place.name,
                      style: AppTextStyles.heading1.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 34,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Shibuya City, Tokyo',
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: Text(
                        'Rate your visit',
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(5, (index) {
                        final isActive = index < _selectedRating;
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedRating = index + 1;
                            });
                          },
                          icon: Icon(
                            isActive
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 34,
                            color: isActive
                                ? const Color(0xFFFBBF24)
                                : const Color(0xFFE5E7EB),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F5F5),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x14FF6B5A),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: _noteController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: AppTextStyles.body1.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '0/500',
                              style: AppTextStyles.caption.copyWith(
                                color: const Color(0xFFD9C1BE),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: <Widget>[
                        Text(
                          'Add Photos/Videos',
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'View All',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: <Widget>[
                        _AddMediaTile(onTap: () {}),
                        const SizedBox(width: 14),
                        _PreviewMediaTile(path: 'assets/images/bean_bloom.png'),
                        const SizedBox(width: 14),
                        _PreviewMediaTile(path: 'assets/images/korea_food.jpeg'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _InfoActionCard(
                      icon: Icons.person_add_alt_rounded,
                      title: 'Tag Friends',
                      subtitle: 'With who did you go?',
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F5F5),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x12FF6B5A),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          _InfoActionCard(
                            icon: Icons.lock_outline_rounded,
                            title: 'Visibility',
                            subtitle: 'Who can see this log?',
                            showChevron: false,
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF9C9493),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: <Widget>[
                                for (final option in const <String>[
                                  'Public',
                                  'Friends',
                                  'Private',
                                ])
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _visibility = option;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 180),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _visibility == option
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        child: Text(
                                          option,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.body2.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
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
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: <Widget>[
                        Text(
                          'Date visited',
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Today, Oct 24',
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: AppTextStyles.body1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
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
}

class _InfoActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool showChevron;

  const _InfoActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFFDE6D5),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (showChevron)
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9CA3AF),
          ),
      ],
    );
  }
}

class _AddMediaTile extends StatelessWidget {
  final VoidCallback onTap;

  const _AddMediaTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 112,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7F7),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFF8B4D9),
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.add_a_photo_outlined,
                color: AppColors.primary,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                'ADD',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewMediaTile extends StatelessWidget {
  final String path;

  const _PreviewMediaTile({required this.path});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          path,
          height: 112,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
