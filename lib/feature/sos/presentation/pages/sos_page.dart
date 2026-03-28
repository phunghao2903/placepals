import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/sos_feed.dart';
import '../bloc/sos_bloc.dart';
import '../widgets/sos_description_field.dart';
import '../widgets/sos_emergency_card.dart';
import '../widgets/sos_visibility_switch.dart';

class SosPage extends StatelessWidget {
  const SosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SosBloc>(
      create: (_) => getIt<SosBloc>()..add(const SosStarted()),
      child: const _SosView(),
    );
  }
}

class _SosView extends StatefulWidget {
  const _SosView();

  @override
  State<_SosView> createState() => _SosViewState();
}

class _SosViewState extends State<_SosView> {
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SosBloc, SosState>(
        listenWhen: (previous, current) =>
            previous.description != current.description,
        listener: (context, state) {
          if (_descriptionController.text != state.description) {
            _descriptionController.value = TextEditingValue(
              text: state.description,
              selection: TextSelection.collapsed(
                offset: state.description.length,
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case SosStatus.initial:
            case SosStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case SosStatus.failure:
              return Center(
                child: Text(
                  state.errorMessage ?? 'Something went wrong.',
                  style: AppTextStyles.body2,
                ),
              );
            case SosStatus.success:
              final feed = state.feed;
              if (feed == null) return const SizedBox.shrink();
              return _SosContent(
                feed: feed,
                descriptionController: _descriptionController,
              );
          }
        },
      ),
    );
  }
}

class _SosContent extends StatelessWidget {
  static const Color _sheetBackground = Color(0xFFF4F1F0);
  static const Color _subtitleColor = Color(0xFFAAAFB6);
  static const Color _titleColor = Color(0xFF595E69);
  static const Color _closeColor = Color(0xFF7A8090);

  final SosFeed feed;
  final TextEditingController descriptionController;

  const _SosContent({
    required this.feed,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned.fill(
          child: ColoredBox(color: Colors.white),
        ),
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
                            feed.title,
                            style: AppTextStyles.heading2.copyWith(
                              fontSize: 17,
                              color: _titleColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).maybePop(),
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
                      feed.subtitle,
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
                      children: feed.emergencyTypes
                          .map(
                            (item) => SosEmergencyCard(
                              title: item.title,
                              iconKey: item.iconKey,
                              isSelected: item.isSelected,
                              onTap: () {
                                context.read<SosBloc>().add(
                                      SosEmergencyTypeSelected(
                                        typeId: item.id,
                                      ),
                                    );
                              },
                            ),
                          )
                          .toList(growable: false),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      feed.descriptionLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SosDescriptionField(
                        controller: descriptionController,
                        hintText: feed.descriptionHint,
                        onChanged: (value) {
                          context.read<SosBloc>().add(
                                SosDescriptionChanged(description: value),
                              );
                        },
                      ),
                    ),
                    const SizedBox(height: 44),
                    Text(
                      feed.visibilityScopeLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Center(
                      child: SosVisibilitySwitch(
                        items: feed.visibilityScopes,
                        onSelected: (scopeId) {
                          context.read<SosBloc>().add(
                                SosVisibilityScopeSelected(scopeId: scopeId),
                              );
                        },
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
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            final selectedEmergency = feed.emergencyTypes
                                .firstWhere((item) => item.isSelected);
                            final selectedScope = feed.visibilityScopes
                                .firstWhere((item) => item.isSelected);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Alert sent: ${selectedEmergency.title.replaceAll('\n', ' ')} to ${selectedScope.label}.",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            feed.sendHelpLabel,
                            style: AppTextStyles.heading6.copyWith(
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
            ),
          ),
        ),
      ],
    );
  }
}
