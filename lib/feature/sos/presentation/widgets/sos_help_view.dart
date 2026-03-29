import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/sos_feed.dart';
import 'sos_description_field.dart';
import 'sos_emergency_card.dart';
import 'sos_visibility_switch.dart';

class SosHelpView extends StatelessWidget {
  static const Color _sheetBackground = Color(0xFFF4F1F0);
  static const Color _subtitleColor = Color(0xFFAAAFB6);
  static const Color _titleColor = Color(0xFF595E69);
  static const Color _closeColor = Color(0xFF7A8090);

  final SosHelpComposer composer;
  final TextEditingController descriptionController;
  final bool isSendingAlert;
  final VoidCallback onClose;
  final ValueChanged<String> onEmergencyTypeSelected;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<String> onVisibilityScopeSelected;
  final VoidCallback onSubmit;

  const SosHelpView({
    super.key,
    required this.composer,
    required this.descriptionController,
    required this.isSendingAlert,
    required this.onClose,
    required this.onEmergencyTypeSelected,
    required this.onDescriptionChanged,
    required this.onVisibilityScopeSelected,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned.fill(child: ColoredBox(color: Colors.white)),
        Positioned.fill(
          top: 116,
          child: Container(
            decoration: const BoxDecoration(
              color: _sheetBackground,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        Container(
                          width: 43,
                          height: 5,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC6CBD3),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            composer.title,
                            style: AppTextStyles.heading2.copyWith(
                              fontSize: 17,
                              color: _titleColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: onClose,
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.close_rounded,
                              size: 26,
                              color: _closeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      composer.subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: _subtitleColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 28,
                      runSpacing: 18,
                      children: composer.emergencyTypes
                          .map(
                            (item) => SosEmergencyCard(
                              title: item.title,
                              iconKey: item.iconKey,
                              isSelected: item.isSelected,
                              onTap: () => onEmergencyTypeSelected(item.id),
                            ),
                          )
                          .toList(growable: false),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      composer.descriptionLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SosDescriptionField(
                        controller: descriptionController,
                        hintText: composer.descriptionHint,
                        onChanged: onDescriptionChanged,
                      ),
                    ),
                    const SizedBox(height: 44),
                    Text(
                      composer.visibilityScopeLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Center(
                      child: SosVisibilitySwitch(
                        items: composer.visibilityScopes,
                        onSelected: onVisibilityScopeSelected,
                      ),
                    ),
                    const SizedBox(height: 63),
                    Center(
                      child: SizedBox(
                        width: 313,
                        height: 53,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppSemanticColors.primary,
                            disabledBackgroundColor: BrandColors.primary300,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: isSendingAlert ? null : onSubmit,
                          child: isSendingAlert
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  composer.sendHelpLabel,
                                  style: AppTextStyles.heading6.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        'Pressing send will alert your selected contacts immediately',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption.copyWith(
                          color: BrandColors.primary900,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
