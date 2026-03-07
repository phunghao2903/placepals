import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../bloc/bottom_appbar_bloc.dart';
import '../widgets/bottom_nav_item.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const <Widget>[
      HomePage(),
      _BottomPlaceholderPage(title: 'Saved'),
      _BottomPlaceholderPage(title: 'SOS'),
      _BottomPlaceholderPage(title: 'Profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomAppBarBloc>(
      create: (_) => getIt<BottomAppBarBloc>(),
      child: BlocBuilder<BottomAppBarBloc, BottomAppBarState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            backgroundColor: AppColors.background,
            body: IndexedStack(
              index: state.currentIndex,
              children: _pages,
            ),
            floatingActionButton: _CenterAddButton(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Add action is not connected yet.'),
                  ),
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _PlacePalsBottomAppBar(
              currentIndex: state.currentIndex,
            ),
          );
        },
      ),
    );
  }
}

class _PlacePalsBottomAppBar extends StatelessWidget {
  final int currentIndex;

  const _PlacePalsBottomAppBar({
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      height: 88,
      color: AppColors.surface,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BottomNavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              isActive: currentIndex == 0,
              onTap: () {
                context.read<BottomAppBarBloc>().add(
                  const BottomAppBarTabChanged(index: 0),
                );
              },
            ),
            BottomNavItem(
              icon: Icons.bookmark_border_rounded,
              label: 'Saved',
              isActive: currentIndex == 1,
              onTap: () {
                context.read<BottomAppBarBloc>().add(
                  const BottomAppBarTabChanged(index: 1),
                );
              },
            ),
            const SizedBox(width: 48),
            BottomNavItem(
              icon: Icons.sos_outlined,
              label: 'SOS',
              isActive: currentIndex == 2,
              onTap: () {
                context.read<BottomAppBarBloc>().add(
                  const BottomAppBarTabChanged(index: 2),
                );
              },
            ),
            BottomNavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              isActive: currentIndex == 3,
              onTap: () {
                context.read<BottomAppBarBloc>().add(
                  const BottomAppBarTabChanged(index: 3),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CenterAddButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      onPressed: onTap,
      child: const Icon(Icons.add_rounded, size: 30),
    );
  }
}

class _BottomPlaceholderPage extends StatelessWidget {
  final String title;

  const _BottomPlaceholderPage({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.heading4.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
