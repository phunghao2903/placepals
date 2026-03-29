import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../bottom_appbar/presentation/bloc/bottom_appbar_bloc.dart';
import '../../domain/entities/sos_feed.dart';
import '../bloc/sos_bloc.dart';
import '../widgets/sos_active_alert_view.dart';
import '../widgets/sos_help_view.dart';
import '../widgets/sos_intro_view.dart';

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

  void _closeToHome(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }

    try {
      context.read<BottomAppBarBloc>().add(
            const BottomAppBarTabChanged(index: 0),
          );
    } catch (_) {
      // SOS can also be opened standalone without the bottom bar bloc.
    }
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
              final SosFeed? feed = state.feed;
              if (feed == null) {
                return const SizedBox.shrink();
              }

              switch (state.viewStep) {
                case SosViewStep.intro:
                  return SosIntroView(
                    intro: feed.intro,
                    onPrimaryAction: () {
                      context.read<SosBloc>().add(const SosComposerOpened());
                    },
                    onClose: () => _closeToHome(context),
                  );
                case SosViewStep.helpComposer:
                  return SosHelpView(
                    composer: feed.helpComposer,
                    descriptionController: _descriptionController,
                    isSendingAlert: state.isSendingAlert,
                    onClose: () {
                      context.read<SosBloc>().add(const SosBackPressed());
                    },
                    onEmergencyTypeSelected: (typeId) {
                      context.read<SosBloc>().add(
                            SosEmergencyTypeSelected(typeId: typeId),
                          );
                    },
                    onDescriptionChanged: (value) {
                      context.read<SosBloc>().add(
                            SosDescriptionChanged(description: value),
                          );
                    },
                    onVisibilityScopeSelected: (scopeId) {
                      context.read<SosBloc>().add(
                            SosVisibilityScopeSelected(scopeId: scopeId),
                          );
                    },
                    onSubmit: () {
                      context.read<SosBloc>().add(const SosAlertSubmitted());
                    },
                  );
                case SosViewStep.activeAlert:
                  return SosActiveAlertView(
                    alert: feed.activeAlert,
                    showResponders: state.showActiveResponders,
                    onBack: () {
                      context.read<SosBloc>().add(const SosBackPressed());
                    },
                    onMarkSafe: () {
                      context.read<SosBloc>().add(const SosMarkedSafe());
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Emergency signal marked as safe.'),
                          ),
                        );
                    },
                  );
              }
          }
        },
      ),
    );
  }
}
