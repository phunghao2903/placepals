import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/sos_feed.dart';
import 'sos_description_field.dart';
import 'sos_emergency_card.dart';
import 'sos_visibility_switch.dart';

class SosHelpView extends StatelessWidget {
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
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onClose,
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.close_rounded,
                        size: 24,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  composer.title,
                  style: AppTextStyles.heading6.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  composer.subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: NeutralColors.neutral700,
                    letterSpacing: 0.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: composer.emergencyTypes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.08,
                  ),
                  itemBuilder: (context, index) {
                    final item = composer.emergencyTypes[index];
                    return SosEmergencyCard(
                      title: item.title,
                      iconKey: item.iconKey,
                      isSelected: item.isSelected,
                      onTap: () => onEmergencyTypeSelected(item.id),
                    );
                  },
                ),
                const SizedBox(height: 22),
                Text(
                  composer.descriptionLabel,
                  style: AppTextStyles.caption.copyWith(
                    color: NeutralColors.neutral700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                SosDescriptionField(
                  controller: descriptionController,
                  hintText: composer.descriptionHint,
                  onChanged: onDescriptionChanged,
                ),
                const SizedBox(height: 18),
                Text(
                  composer.visibilityScopeLabel,
                  style: AppTextStyles.caption.copyWith(
                    color: NeutralColors.neutral700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                SosVisibilitySwitch(
                  items: composer.visibilityScopes,
                  onSelected: onVisibilityScopeSelected,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isSendingAlert ? null : onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppSemanticColors.primary,
                      disabledBackgroundColor: BrandColors.primary300,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
