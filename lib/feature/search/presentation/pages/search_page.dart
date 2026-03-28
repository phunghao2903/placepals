import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/search_destination.dart';
import '../../domain/entities/search_filter.dart';
import '../bloc/search_bloc.dart';
import '../widgets/search_bar_input.dart';
import '../widgets/search_destination_card.dart';
import '../widgets/search_filter_chip.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (_) => getIt<SearchBloc>()..add(const SearchStarted()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F7),
      body: SafeArea(
        child: BlocConsumer<SearchBloc, SearchState>(
          listenWhen: (previous, current) => previous.query != current.query,
          listener: (context, state) {
            if (_controller.text != state.query) {
              _controller.value = TextEditingValue(
                text: state.query,
                selection: TextSelection.collapsed(offset: state.query.length),
              );
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case SearchStatus.initial:
              case SearchStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case SearchStatus.failure:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Something went wrong.',
                    style: AppTextStyles.body2,
                  ),
                );
              case SearchStatus.success:
                final feed = state.feed;
                if (feed == null) return const SizedBox.shrink();
                final filters = state.filters.cast<SearchFilter>();
                final destinations = state.visibleDestinations
                    .cast<SearchDestination>();

                if (_controller.text != state.query) {
                  _controller.value = TextEditingValue(
                    text: state.query,
                    selection: TextSelection.collapsed(
                      offset: state.query.length,
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.fromLTRB(14, 24, 14, 30),
                  children: <Widget>[
                    SearchBarInput(
                      controller: _controller,
                      hintText: feed.searchHint,
                      onChanged: (value) {
                        context.read<SearchBloc>().add(
                          SearchQueryChanged(query: value),
                        );
                      },
                      onBack: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: List<Widget>.generate(filters.length, (index) {
                        final item = filters[index];
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: index == filters.length - 1 ? 0 : 10,
                            ),
                            child: SearchFilterChip(
                              label: item.label,
                              isSelected: item.isSelected,
                              onTap: () {
                                context.read<SearchBloc>().add(
                                  SearchFilterSelected(filterId: item.id),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    ...List<Widget>.generate(destinations.length, (index) {
                      final item = destinations[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == destinations.length - 1 ? 0 : 20,
                        ),
                        child: SearchDestinationCard(
                          destination: item,
                          query: state.query,
                          onToggleFavorite: () {
                            context.read<SearchBloc>().add(
                              SearchFavoriteToggled(destinationId: item.id),
                            );
                          },
                        ),
                      );
                    }),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
