import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/profile_feed.dart';

const Color _editPlaceCanvas = Color(0xFFFFFAF8);
const Color _editPlaceStroke = Color(0xFFF3E8E5);
const Color _editPlaceAccent = Color(0xFFFF6B5A);
const Color _editPlaceFieldFill = Color(0xFFF8F4F3);
const Color _editPlaceInfoBackground = Color(0xFFF0F6FF);
const Color _editPlaceInfoBorder = Color(0xFFD7E7FF);

class EditPlacePage extends StatefulWidget {
  final ProfilePlaceItem place;

  const EditPlacePage({super.key, required this.place});

  @override
  State<EditPlacePage> createState() => _EditPlacePageState();
}

class _EditPlacePageState extends State<EditPlacePage> {
  static const int _descriptionLimit = 500;

  late final TextEditingController _placeNameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _addressController;

  late final _EditablePlaceSeed _seed;
  late String _selectedCategory;
  late String _selectedPriceRange;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _seed = _EditablePlaceSeed.fromPlace(widget.place);
    _selectedCategory = _seed.category;
    _selectedPriceRange = _seed.priceRange;
    _selectedStatus = _seed.status;
    _placeNameController = TextEditingController(text: widget.place.title);
    _descriptionController = TextEditingController(text: _seed.description)
      ..addListener(_refresh);
    _addressController = TextEditingController(text: _seed.address);
  }

  @override
  void dispose() {
    _placeNameController.dispose();
    _descriptionController
      ..removeListener(_refresh)
      ..dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final descriptionLength = _descriptionController.text.characters.length;

    return Scaffold(
      backgroundColor: _editPlaceCanvas,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _EditPlaceHeader(
                      onBack: () => Navigator.of(context).pop(),
                      onDelete: _showDeleteStub,
                    ),
                    const SizedBox(height: 18),
                    _EditPlaceHero(
                      imagePath: widget.place.imagePath,
                      helperText:
                          'Click to upload a new photo from your device',
                      onEditImage: _showPhotoStub,
                    ),
                    const SizedBox(height: 16),
                    _EditPlaceTextField(
                      label: 'Place Name *',
                      controller: _placeNameController,
                      hintText: 'Enter place name',
                    ),
                    const SizedBox(height: 12),
                    _EditPlaceDropdownField(
                      label: 'Category *',
                      value: _selectedCategory,
                      items: _EditablePlaceSeed.categories,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _EditPlaceDescriptionField(
                      controller: _descriptionController,
                      currentLength: descriptionLength,
                      maxLength: _descriptionLimit,
                    ),
                    const SizedBox(height: 12),
                    _EditPlaceTextField(
                      label: 'Address *',
                      controller: _addressController,
                      hintText: 'Enter address',
                      leadingIcon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: _SelectionSection<String>(
                            label: 'Price Range',
                            value: _selectedPriceRange,
                            options: _EditablePlaceSeed.priceRanges,
                            onSelected: (value) {
                              setState(() {
                                _selectedPriceRange = value;
                              });
                            },
                            itemLabelBuilder: (item) => item,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SelectionSection<_StatusOption>(
                            label: 'Status',
                            value: _selectedStatus,
                            options: _EditablePlaceSeed.statusOptions,
                            onSelected: (value) {
                              setState(() {
                                _selectedStatus = value.value;
                              });
                            },
                            itemLabelBuilder: (item) => item.label,
                            itemValueBuilder: (item) => item.value,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _CurrentRatingCard(
                      rating: widget.place.rating,
                      reviewsLabel: _seed.reviewsLabel,
                    ),
                    const SizedBox(height: 12),
                    const _TipsCard(),
                  ],
                ),
              ),
            ),
            _BottomActionBar(
              onCancel: () => Navigator.of(context).pop(),
              onSave: _saveChanges,
            ),
          ],
        ),
      ),
    );
  }

  void _showPhotoStub() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Photo editing is not implemented yet.')),
    );
  }

  void _showDeleteStub() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Delete flow for ${widget.place.title} is not implemented yet.',
        ),
      ),
    );
  }

  void _saveChanges() {
    final descriptionLength = _descriptionController.text.characters.length;

    if (_placeNameController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty ||
        descriptionLength > _descriptionLimit) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete the required fields correctly.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_placeNameController.text.trim()} updated successfully.',
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}

class _EditPlaceHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onDelete;

  const _EditPlaceHeader({required this.onBack, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CircleIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Edit Place',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        _CircleIconButton(
          icon: Icons.delete_outline_rounded,
          iconColor: _editPlaceAccent,
          onTap: onDelete,
        ),
      ],
    );
  }
}

class _EditPlaceHero extends StatelessWidget {
  final String imagePath;
  final String helperText;
  final VoidCallback onEditImage;

  const _EditPlaceHero({
    required this.imagePath,
    required this.helperText,
    required this.onEditImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: <Widget>[
              Image.asset(
                imagePath,
                height: 148,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Colors.black.withValues(alpha: 0.24),
                        Colors.black.withValues(alpha: 0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xE62D2D2D),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onEditImage,
                    child: const SizedBox(
                      width: 34,
                      height: 34,
                      child: Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: _editPlaceAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          helperText,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _EditPlaceTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData? leadingIcon;

  const _EditPlaceTextField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: _editPlaceFieldFill,
            prefixIcon: leadingIcon == null
                ? null
                : Icon(leadingIcon, size: 18, color: AppColors.textSecondary),
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
              borderSide: const BorderSide(color: _editPlaceAccent),
            ),
          ),
        ),
      ],
    );
  }
}

class _EditPlaceDropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _EditPlaceDropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: _editPlaceFieldFill,
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
              borderSide: const BorderSide(color: _editPlaceAccent),
            ),
          ),
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: Colors.white,
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              )
              .toList(growable: false),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _EditPlaceDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final int currentLength;
  final int maxLength;

  const _EditPlaceDescriptionField({
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
          'Description',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 5,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: 'Tell others about this place...',
            hintStyle: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: _editPlaceFieldFill,
            contentPadding: const EdgeInsets.all(14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: _editPlaceAccent),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            Text(
              '$currentLength/$maxLength characters',
              style: AppTextStyles.caption.copyWith(
                color: isOverflow ? AppColors.error : AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
            const Spacer(),
            Text(
              'You can rewrite this any time',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SelectionSection<T> extends StatelessWidget {
  final String label;
  final String value;
  final List<T> options;
  final ValueChanged<T> onSelected;
  final String Function(T item) itemLabelBuilder;
  final String Function(T item)? itemValueBuilder;

  const _SelectionSection({
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
    required this.itemLabelBuilder,
    this.itemValueBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: options
              .map((option) {
                final optionValue =
                    itemValueBuilder?.call(option) ?? option.toString();
                final isSelected = optionValue == value;

                return GestureDetector(
                  onTap: () => onSelected(option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFFEFEA)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? _editPlaceAccent : _editPlaceStroke,
                      ),
                    ),
                    child: Text(
                      itemLabelBuilder(option),
                      style: AppTextStyles.caption.copyWith(
                        color: isSelected
                            ? _editPlaceAccent
                            : AppColors.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                );
              })
              .toList(growable: false),
        ),
      ],
    );
  }
}

class _CurrentRatingCard extends StatelessWidget {
  final double rating;
  final String reviewsLabel;

  const _CurrentRatingCard({required this.rating, required this.reviewsLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _editPlaceStroke),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.star_rounded, size: 18, color: AppColors.warning),
          const SizedBox(width: 6),
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              reviewsLabel,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard();

  @override
  Widget build(BuildContext context) {
    const List<String> tips = <String>[
      'Use well-lit, high-quality photos',
      'Write detailed descriptions with unique features',
      'Keep information up to date',
      'Add specific address for easy navigation',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _editPlaceInfoBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _editPlaceInfoBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tips for better engagement',
            style: AppTextStyles.body2.copyWith(
              color: const Color(0xFF3A72D8),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• $tip',
                style: AppTextStyles.caption.copyWith(
                  color: const Color(0xFF527ABF),
                  fontSize: 10,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const _BottomActionBar({required this.onCancel, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: const BoxDecoration(
        color: _editPlaceCanvas,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x10111827),
            blurRadius: 20,
            offset: Offset(0, -8),
            spreadRadius: -16,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: onCancel,
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  foregroundColor: AppColors.textPrimary,
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
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  elevation: 0,
                  backgroundColor: _editPlaceAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                icon: const Icon(
                  Icons.save_outlined,
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
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.textPrimary,
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
            border: Border.all(color: _editPlaceStroke),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
      ),
    );
  }
}

class _EditablePlaceSeed {
  static const List<String> categories = <String>[
    'Specialty Coffee',
    'Breakfast & Brunch',
    'Outdoor Seating',
    'Bar & Lounge',
    'Restaurant',
    'Classic Cafe',
    'Fast Food',
    'Fine Dining',
  ];

  static const List<String> priceRanges = <String>[
    '\$',
    '\$\$',
    '\$\$\$',
    '\$\$\$\$',
  ];

  static const List<_StatusOption> statusOptions = <_StatusOption>[
    _StatusOption(value: 'open_now', label: 'Open Now'),
    _StatusOption(value: 'busy', label: 'Busy'),
    _StatusOption(value: 'featured', label: 'Featured'),
  ];

  final String category;
  final String description;
  final String address;
  final String priceRange;
  final String status;
  final String reviewsLabel;

  const _EditablePlaceSeed({
    required this.category,
    required this.description,
    required this.address,
    required this.priceRange,
    required this.status,
    required this.reviewsLabel,
  });

  factory _EditablePlaceSeed.fromPlace(ProfilePlaceItem place) {
    switch (place.id) {
      case 'garden_terrace':
      case 'garden_terrace_hoi_an':
        return const _EditablePlaceSeed(
          category: 'Breakfast & Brunch',
          description:
              'A cozy coffee shop with artisan beans and comfortable seating. Perfect for remote work or catching up with friends.',
          address: '123 Main Street, Da Nang',
          priceRange: '\$\$\$',
          status: 'featured',
          reviewsLabel: 'Based on 522 user reviews',
        );
      case 'sunset_rooftop':
      case 'sunset_rooftop_hoi_an':
        return const _EditablePlaceSeed(
          category: 'Bar & Lounge',
          description:
              'A rooftop hangout with panoramic sunset views, creative mocktails, and a relaxed evening crowd.',
          address: '18 Riverside Road, Hue',
          priceRange: '\$\$\$\$',
          status: 'busy',
          reviewsLabel: 'Based on 318 user reviews',
        );
      case 'art_gallery':
      case 'art_gallery_hoi_an':
        return const _EditablePlaceSeed(
          category: 'Classic Cafe',
          description:
              'An artsy cafe with local exhibitions, warm lighting, and signature desserts that make the space memorable.',
          address: '44 Le Loi Street, Hoi An',
          priceRange: '\$\$',
          status: 'open_now',
          reviewsLabel: 'Based on 264 user reviews',
        );
      default:
        return const _EditablePlaceSeed(
          category: 'Specialty Coffee',
          description:
              'A cozy coffee shop with artisan beans and comfortable seating. Perfect for remote work or catching up with friends.',
          address: '123 Main Street, Da Nang',
          priceRange: '\$\$',
          status: 'open_now',
          reviewsLabel: 'Based on 403 user reviews',
        );
    }
  }
}

class _StatusOption {
  final String value;
  final String label;

  const _StatusOption({required this.value, required this.label});
}
