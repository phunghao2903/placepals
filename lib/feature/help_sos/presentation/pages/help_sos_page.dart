import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/help_sos_feed.dart';
import '../bloc/help_sos_bloc.dart';
import '../widgets/help_sos_alert_view.dart';
import '../widgets/help_sos_call_view.dart';
import '../widgets/help_sos_rescue_map_view.dart';

class HelpSosPage extends StatelessWidget {
  const HelpSosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HelpSosBloc>(
      create: (_) => getIt<HelpSosBloc>()..add(const HelpSosStarted()),
      child: const _HelpSosView(),
    );
  }
}

class _HelpSosView extends StatelessWidget {
  const _HelpSosView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HelpSosBloc, HelpSosState>(
        builder: (context, state) {
          switch (state.status) {
            case HelpSosStatus.initial:
            case HelpSosStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case HelpSosStatus.failure:
              return Center(
                child: Text(
                  state.errorMessage ?? 'Something went wrong.',
                  style: AppTextStyles.body2,
                ),
              );
            case HelpSosStatus.success:
              final HelpSosFeed? feed = state.feed;
              final HelpSosAlert? alert = state.selectedAlert;
              if (feed == null || alert == null) {
                return const SizedBox.shrink();
              }

              switch (state.screen) {
                case HelpSosScreen.alert:
                  return HelpSosAlertView(
                    alert: alert,
                    onClose: () => Navigator.of(context).maybePop(),
                    onGoToLocation: () {
                      context.read<HelpSosBloc>().add(
                            const HelpSosGoToLocationTapped(),
                          );
                    },
                    onCallNow: () {
                      context.read<HelpSosBloc>().add(
                            const HelpSosCallNowTapped(),
                          );
                    },
                  );
                case HelpSosScreen.rescueMap:
                  return HelpSosRescueMapView(
                    rescueMap: feed.rescueMap,
                    hasArrived: state.hasArrived,
                    onBack: () {
                      context.read<HelpSosBloc>().add(
                            const HelpSosBackPressed(),
                          );
                    },
                    onCallNow: () {
                      context.read<HelpSosBloc>().add(
                            const HelpSosCallNowTapped(),
                          );
                    },
                    onImHere: () {
                      context.read<HelpSosBloc>().add(
                            const HelpSosArrivedTapped(),
                          );
                    },
                  );
                case HelpSosScreen.call:
                  return HelpSosCallView(
                    session: feed.callSession,
                    onEndCall: () {
                      context.read<HelpSosBloc>().add(
                            const HelpSosCallEnded(),
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
