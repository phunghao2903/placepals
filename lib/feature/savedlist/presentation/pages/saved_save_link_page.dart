import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';
import '../widgets/save_to_collection_sheet.dart';

class SavedSaveLinkPage extends StatefulWidget {
  final List<CollectionChoice> choices;
  final String title;
  final String firstFieldLabel;
  final String firstFieldInitialValue;
  final String firstFieldHintText;
  final bool showPasteIcon;
  final String actionButtonLabel;
  final bool saveToCollectionOnSubmit;

  const SavedSaveLinkPage({
    super.key,
    required this.choices,
    this.title = 'Save Link',
    this.firstFieldLabel = 'Link',
    this.firstFieldInitialValue = 'https://ww.toktok.comm',
    this.firstFieldHintText = '',
    this.showPasteIcon = true,
    this.actionButtonLabel = 'Save to Collection',
    this.saveToCollectionOnSubmit = true,
  });

  static Route<void> route({
    required List<CollectionChoice> choices,
    String title = 'Save Link',
    String firstFieldLabel = 'Link',
    String firstFieldInitialValue = 'https://ww.toktok.comm',
    String firstFieldHintText = '',
    bool showPasteIcon = true,
    String actionButtonLabel = 'Save to Collection',
    bool saveToCollectionOnSubmit = true,
  }) {
    return PageRouteBuilder<void>(
      opaque: false,
      barrierColor: const Color(0x66000000),
      pageBuilder: (context, animation, secondaryAnimation) =>
          SavedSaveLinkPage(
            choices: choices,
            title: title,
            firstFieldLabel: firstFieldLabel,
            firstFieldInitialValue: firstFieldInitialValue,
            firstFieldHintText: firstFieldHintText,
            showPasteIcon: showPasteIcon,
            actionButtonLabel: actionButtonLabel,
            saveToCollectionOnSubmit: saveToCollectionOnSubmit,
          ),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<SavedSaveLinkPage> createState() => _SavedSaveLinkPageState();
}

class _SavedSaveLinkPageState extends State<SavedSaveLinkPage> {
  late final TextEditingController _linkController;
  late final TextEditingController _noteController;
  final Set<String> _selectedTags = <String>{'#date-night'};

  static const List<String> _allTags = <String>[
    '#date-night',
    '#cafe',
    '#hidden-gem',
    '#cocktails',
  ];

  @override
  void initState() {
    super.initState();
    _linkController = TextEditingController(
      text: widget.firstFieldInitialValue,
    );
    _noteController = TextEditingController(
      text: 'This cafe has incredibly delicious tiramisu.',
    );
  }

  @override
  void dispose() {
    _linkController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 30,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => Navigator.of(context).maybePop(),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.close_rounded,
                              color: Color(0xFF9C9493),
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _SheetField(
                      label: widget.firstFieldLabel,
                      child: TextField(
                        controller: _linkController,
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: widget.firstFieldHintText,
                          suffixIcon: widget.showPasteIcon
                              ? const Icon(
                                  Icons.content_paste_rounded,
                                  color: AppColors.primary,
                                  size: 20,
                                )
                              : null,
                          suffixIconConstraints:
                              const BoxConstraints(minHeight: 20, minWidth: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SheetField(
                      label: 'Note',
                      child: TextField(
                        controller: _noteController,
                        maxLines: 4,
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.3,
                        ),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: <Widget>[
                        Text(
                          'Tags',
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Manage',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        ..._allTags.map(_buildTagChip),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF9CA3AF),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            size: 18,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: FilledButton.icon(
                        onPressed: _handleSave,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(29),
                          ),
                        ),
                        icon: const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          widget.actionButtonLabel,
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
          ),
        ),
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    final isSelected = _selectedTags.contains(tag);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTags.remove(tag);
          } else {
            _selectedTags.add(tag);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFEFEE) : const Color(0xFFF7F4F4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFC8C1) : Colors.transparent,
          ),
        ),
        child: Text(
          tag,
          style: AppTextStyles.body2.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!widget.saveToCollectionOnSubmit) {
      Navigator.of(context).pop();
      return;
    }

    final selected = await showSaveToCollectionSheet(
      context,
      placeName: 'Blue Bottle Coffee',
      choices: widget.choices,
    );
    if (!mounted || selected.isEmpty) {
      return;
    }

    Navigator.of(context).pop();
  }
}

class _SheetField extends StatelessWidget {
  final String label;
  final Widget child;

  const _SheetField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.body1.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F5F5),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x12FF6B5A),
                blurRadius: 14,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}
