import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/core.dart';
import '../../domain/entities/appointment_feed.dart';
import '../bloc/appointment_bloc.dart';
import 'appointment_add_friends_page.dart';
import 'appointment_select_when_page.dart';
import 'appointment_suggest_place_page.dart';
import '../widgets/appointment_empty_state.dart';
import '../widgets/appointment_form_field.dart';
import '../widgets/appointment_header.dart';
import '../widgets/appointment_invitee_avatar.dart';
import '../widgets/appointment_primary_button.dart';
import '../widgets/appointment_when_chip.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentBloc>(
      create: (_) => getIt<AppointmentBloc>()..add(const AppointmentStarted()),
      child: const _AppointmentView(),
    );
  }
}

class _AppointmentView extends StatelessWidget {
  const _AppointmentView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F5),
      body: SafeArea(
        child: BlocConsumer<AppointmentBloc, AppointmentState>(
          listenWhen: (previous, current) =>
              previous.infoMessage != current.infoMessage &&
              current.infoMessage != null &&
              current.infoMessage!.isNotEmpty,
          listener: (context, state) {
            if (state.infoMessage != null && state.infoMessage!.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.infoMessage!)),
              );
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case AppointmentStatus.initial:
              case AppointmentStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case AppointmentStatus.failure:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      state.errorMessage ?? 'Something went wrong.',
                      style: AppTextStyles.body2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              case AppointmentStatus.success:
                final feed = state.feed;
                if (feed == null) {
                  return const SizedBox.shrink();
                }
                if (feed.invitees.isEmpty) {
                  return const AppointmentEmptyState(
                    title: 'No friends available',
                    description: 'Add friends first so you can invite them to a new hangout.',
                  );
                }

                return Column(
                  children: <Widget>[
                    AppointmentHeader(
                      title: feed.title,
                      onClose: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AppointmentFormField(
                              label: feed.planNameLabel,
                              hintText: feed.planNameHint,
                              initialValue: feed.planName,
                              showAccentBorder: true,
                              onChanged: (value) {
                                context.read<AppointmentBloc>().add(
                                  AppointmentPlanNameChanged(value: value),
                                );
                              },
                            ),
                            const SizedBox(height: 31),
                            _SectionLabel(label: feed.whenLabel, isPrimary: true),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: <Widget>[
                                AppointmentWhenChip(
                                  icon: Icons.calendar_today_outlined,
                                  label: feed.dateLabel,
                                  onTap: () => _openWhenPage(
                                    context,
                                    feed.dateLabel,
                                    feed.timeLabel,
                                  ),
                                ),
                                AppointmentWhenChip(
                                  icon: Icons.access_time_rounded,
                                  label: feed.timeLabel,
                                  onTap: () => _openWhenPage(
                                    context,
                                    feed.dateLabel,
                                    feed.timeLabel,
                                  ),
                                ),
                                AppointmentWhenChip(
                                  icon: Icons.edit_outlined,
                                  label: '',
                                  isSoft: false,
                                  onTap: () => _openWhenPage(
                                    context,
                                    feed.dateLabel,
                                    feed.timeLabel,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 31),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: _SectionLabel(
                                    label: feed.guestsLabel,
                                    isPrimary: true,
                                  ),
                                ),
                                Text(
                                  '${feed.selectedCount} selected',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF94A3B8),
                                    height: 1.43,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 116,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    AppointmentInviteButton(
                                      onTap: () => _openAddFriendsPage(
                                        context,
                                        feed.invitees,
                                      ),
                                    ),
                                    ...feed.invitees.map(
                                      (invitee) => AppointmentInviteeAvatar(
                                        invitee: invitee,
                                        onTap: () {
                                          context.read<AppointmentBloc>().add(
                                            AppointmentInviteeToggled(
                                              inviteeId: invitee.id,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 31),
                            AppointmentFormField(
                              label: feed.descriptionLabel,
                              hintText: feed.descriptionHint,
                              initialValue: feed.description,
                              isTextArea: true,
                              onChanged: (value) {
                                context.read<AppointmentBloc>().add(
                                  AppointmentDescriptionChanged(value: value),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                    _BottomActionBar(
                      label: feed.ctaLabel,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => AppointmentSuggestPlacePage(
                              title: feed.planName.trim().isEmpty
                                  ? 'Saturday Dinner'
                                  : feed.planName.trim(),
                              dateLabel: feed.dateLabel,
                              timeLabel: feed.timeLabel,
                              invitees: feed.invitees,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  Future<void> _openAddFriendsPage(
    BuildContext context,
    List<AppointmentInvitee> invitees,
  ) async {
    final result = await Navigator.of(context).push<List<AppointmentInvitee>>(
      MaterialPageRoute<List<AppointmentInvitee>>(
        builder: (_) => AppointmentAddFriendsPage(initialInvitees: invitees),
      ),
    );

    if (result == null || !context.mounted) return;

    context.read<AppointmentBloc>().add(
      AppointmentInviteesUpdated(invitees: result),
    );
  }

  Future<void> _openWhenPage(
    BuildContext context,
    String dateLabel,
    String timeLabel,
  ) async {
    final result = await Navigator.of(context)
        .push<AppointmentWhenSelectionResult>(
      MaterialPageRoute<AppointmentWhenSelectionResult>(
        builder: (_) => AppointmentSelectWhenPage(
          initialDateLabel: dateLabel,
          initialTimeLabel: timeLabel,
        ),
      ),
    );

    if (result == null || !context.mounted) return;

    final bloc = context.read<AppointmentBloc>();
    bloc.add(AppointmentDateChanged(label: result.dateLabel));
    bloc.add(AppointmentTimeChanged(label: result.timeLabel));
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final bool isPrimary;

  const _SectionLabel({
    required this.label,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: isPrimary ? 18 : 16,
          fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
          color: const Color(0xFF0F172A),
          height: isPrimary ? 1.25 : 1.5,
        ),
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _BottomActionBar({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0x00F8F6F5),
            Color(0xFFF8F6F5),
            Color(0xFFF8F6F5),
          ],
          stops: <double>[0, 0.48, 1],
        ),
      ),
      child: AppointmentPrimaryButton(
        label: label,
        onTap: onTap,
      ),
    );
  }
}
