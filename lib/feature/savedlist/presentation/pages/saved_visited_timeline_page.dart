import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';

class SavedVisitedTimelinePage extends StatefulWidget {
  final List<TimelineMonth> timeline;

  const SavedVisitedTimelinePage({super.key, required this.timeline});

  @override
  State<SavedVisitedTimelinePage> createState() =>
      _SavedVisitedTimelinePageState();
}

class _SavedVisitedTimelinePageState extends State<SavedVisitedTimelinePage> {
  String _query = '';
  String _selectedFilter = 'All Time';

  @override
  Widget build(BuildContext context) {
    final filteredTimeline = widget.timeline
        .map(
          (month) => TimelineMonth(
            title: month.title,
            entries: month.entries.where((entry) {
              if (_query.trim().isEmpty) return true;
              final normalized = _query.toLowerCase();
              return entry.placeName.toLowerCase().contains(normalized) ||
                  entry.note.toLowerCase().contains(normalized);
            }).toList(growable: false),
          ),
        )
        .where((month) => month.entries.isNotEmpty)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Visited Timeline',
                    style: AppTextStyles.heading5.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: 'Search places or notes...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF9CA3AF),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: <Widget>[
                  for (final filter in const <String>[
                    'All Time',
                    'District',
                    'Category',
                  ])
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: _TimelineFilterChip(
                        label: filter,
                        selected: _selectedFilter == filter,
                        onTap: () {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                itemCount: filteredTimeline.length,
                itemBuilder: (context, index) {
                  final month = filteredTimeline[index];
                  return _TimelineMonthSection(month: month);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TimelineFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: selected
              ? null
              : Border.all(color: const Color(0xFFE5E7EB), width: 1),
        ),
        child: Row(
          children: <Widget>[
            Text(
              label,
              style: AppTextStyles.body1.copyWith(
                color: selected ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              label == 'Category'
                  ? Icons.filter_list_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: selected ? Colors.white : AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineMonthSection extends StatelessWidget {
  final TimelineMonth month;

  const _TimelineMonthSection({required this.month});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(child: Divider(color: Color(0xFFD8DDE3))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  month.title.toUpperCase(),
                  style: AppTextStyles.body2.copyWith(
                    color: month.title.startsWith('November')
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Color(0xFFD8DDE3))),
            ],
          ),
          const SizedBox(height: 18),
          ...month.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 18,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: month.title.startsWith('November')
                                ? AppColors.primary
                                : const Color(0xFF8F7E78),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 1.5,
                          height: 130,
                          color: const Color(0xFFE5E7EB),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  entry.imagePath,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      entry.placeName,
                                      style: AppTextStyles.heading6.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      entry.visitedAt
                                          .replaceAll('â€¢', '•')
                                          .replaceAll('â€¦', '…'),
                                      style: AppTextStyles.body2.copyWith(
                                        color: month.title.startsWith('November')
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.more_horiz_rounded,
                                color: Color(0xFF9CA3AF),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            entry.note,
                            style: AppTextStyles.body1.copyWith(
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                              height: 1.45,
                            ),
                          ),
                          if (entry.tags.isNotEmpty) ...<Widget>[
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: entry.tags
                                  .map(
                                    (tag) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF7F4F4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        tag.toUpperCase(),
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(growable: false),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
