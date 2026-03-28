import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../ai_recommendation/presentation/pages/ai_recommendation_page.dart';
import '../../../create_moment/presentation/pages/create_moment_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../map/presentation/pages/map_page.dart';
import '../../../sos/presentation/pages/sos_page.dart';
import '../bloc/bottom_appbar_bloc.dart';
import '../widgets/bottom_nav_item.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {
  static const double _bottomBarHeight = 82;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const <Widget>[
      HomePage(),
      MapPage(),
      _BottomPlaceholderPage(title: 'Saved'),
      SosPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomAppBarBloc>(
      create: (_) => BottomAppBarBloc(),
      child: BlocBuilder<BottomAppBarBloc, BottomAppBarState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Scaffold(
                extendBody: true,
                backgroundColor: AppColors.background,
                body: IndexedStack(index: state.currentIndex, children: _pages),
                floatingActionButton: _CenterAddButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const CreateMomentPage(),
                      ),
                    );
                  },
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: _PlacePalsBottomAppBar(
                  currentIndex: state.currentIndex,
                ),
              ),
              Positioned(
                right: 18,
                bottom: _bottomBarHeight + MediaQuery.paddingOf(context).bottom,
                child: _AiAssistantButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const AiRecommendationPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AiAssistantButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AiAssistantButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 64,
          height: 64,
          child: Image.asset(
            'assets/images/ai_button.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _PlacePalsBottomAppBar extends StatelessWidget {
  final int currentIndex;

  const _PlacePalsBottomAppBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      height: _BottomAppBarPageState._bottomBarHeight,
      color: AppSemanticColors.secondary,
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BottomNavItem(
                    iconAsset: 'assets/icons/home.png',
                    label: 'Home',
                    isActive: currentIndex == 0,
                    onTap: () {
                      context.read<BottomAppBarBloc>().add(
                        const BottomAppBarTabChanged(index: 0),
                      );
                    },
                  ),
                  BottomNavItem(
                    iconAsset: 'assets/icons/explore.png',
                    label: 'Explore',
                    isActive: currentIndex == 1,
                    onTap: () {
                      context.read<BottomAppBarBloc>().add(
                        const BottomAppBarTabChanged(index: 1),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 56),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BottomNavItem(
                    iconAsset: 'assets/icons/saved.png',
                    label: 'Saved',
                    isActive: currentIndex == 2,
                    onTap: () {
                      context.read<BottomAppBarBloc>().add(
                        const BottomAppBarTabChanged(index: 2),
                      );
                    },
                  ),
                  BottomNavItem(
                    iconAsset: 'assets/icons/sos.png',
                    label: 'SOS',
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
          ],
        ),
      ),
    );
  }
}

class _CenterAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CenterAddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppSemanticColors.primary,
      shape: const CircleBorder(),
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 54,
          height: 54,
          child: Center(
            child: Transform.translate(
              offset: const Offset(0, -0.5),
              child: const Icon(
                Icons.add_rounded,
                size: 30,
                color: SemanticTextColors.onBrand,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomPlaceholderPage extends StatelessWidget {
  final String title;

  const _BottomPlaceholderPage({required this.title});

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
