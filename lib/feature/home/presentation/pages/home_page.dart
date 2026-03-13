import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../search/presentation/pages/search_page.dart';
import '../../domain/entities/home_feed.dart';
import '../../domain/entities/place_category.dart';
import '../bloc/home_bloc.dart';
import '../widgets/category_chip.dart';
import '../widgets/place_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => getIt<HomeBloc>()..add(const HomeStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch (state.status) {
              case HomeStatus.initial:
              case HomeStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case HomeStatus.failure:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Something went wrong.',
                    style: AppTextStyles.body2,
                  ),
                );
              case HomeStatus.success:
                final feed = state.feed;
                if (feed == null) {
                  return const SizedBox.shrink();
                }
                return _HomeContent(feed: feed);
            }
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final HomeFeed feed;

  const _HomeContent({required this.feed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _HomeTopHeader(city: feed.city),
          const SizedBox(height: 8),
          Text(
            'Explore Nearby',
            style: AppTextStyles.heading4.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SearchPage(),
                  ),
                );
              },
              child: Container(
                height: 47,
                padding: const EdgeInsets.symmetric(horizontal: 11),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.surfaceMuted, width: 1.5),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.textPrimary,
                      size: 22,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Search for cafes,parks...',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 35,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: feed.categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 15),
              itemBuilder: (context, index) {
                final PlaceCategory category = feed.categories[index];
                return CategoryChip(
                  label: category.label,
                  isSelected: category.isSelected,
                  onTap: () {
                    context.read<HomeBloc>().add(
                      HomeCategorySelected(categoryId: category.id),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ...List<Widget>.generate(feed.places.length, (index) {
            final place = feed.places[index];
            return PlaceCard(
              place: place,
              onToggleFavorite: () {
                context.read<HomeBloc>().add(
                  HomeFavoriteToggled(placeId: place.id),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _HomeTopHeader extends StatelessWidget {
  final String city;

  const _HomeTopHeader({required this.city});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.location_on_rounded,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: 10),
            Text(
              city,
              style: AppTextStyles.body2.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            _CalendarActionButton(),
            const SizedBox(width: 11),
            _ProfileButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const ProfilePage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 11),
            const _NotificationActionButton(),
          ],
        ),
      ],
    );
  }
}

class _CalendarActionButton extends StatelessWidget {
  const _CalendarActionButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Image.asset('assets/icons/calendar.png', fit: BoxFit.contain),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ProfileButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFC4C4C4),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(6),
          child: ClipOval(
            child: Image.asset('assets/images/profile.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class _NotificationActionButton extends StatelessWidget {
  const _NotificationActionButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Image.asset('assets/icons/notification.png', fit: BoxFit.contain),
    );
  }
}
