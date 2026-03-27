import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/create_moment_bloc.dart';

class CreateMomentTakePhotoPage extends StatefulWidget {
  final String previewImagePath;

  const CreateMomentTakePhotoPage({
    super.key,
    required this.previewImagePath,
  });

  @override
  State<CreateMomentTakePhotoPage> createState() =>
      _CreateMomentTakePhotoPageState();
}

class _CreateMomentTakePhotoPageState
    extends State<CreateMomentTakePhotoPage> {
  static const List<String> _zoomLevels = <String>['1x', '2x', '3x'];

  String _selectedZoom = '2x';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(widget.previewImagePath, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withOpacity(0.18),
                    Colors.transparent,
                    Colors.black.withOpacity(0.22),
                  ],
                  stops: const <double>[0, 0.45, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
              child: Column(
                children: <Widget>[
                  _CameraTopBar(
                    onClose: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  _ZoomSelector(
                    options: _zoomLevels,
                    selectedZoom: _selectedZoom,
                    onSelected: (value) {
                      setState(() => _selectedZoom = value);
                    },
                  ),
                  const SizedBox(height: 14),
                  const _CameraModeRow(),
                  const SizedBox(height: 18),
                  _CameraBottomBar(
                    previewImagePath: widget.previewImagePath,
                    onCapture: _capturePhoto,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _capturePhoto() {
    context.read<CreateMomentBloc>().add(
      CreateMomentCameraCaptured(imagePath: widget.previewImagePath),
    );
    Navigator.of(context).pop();
  }
}

class _CameraTopBar extends StatelessWidget {
  final VoidCallback onClose;

  const _CameraTopBar({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CameraCircleButton(
          onTap: onClose,
          child: Text(
            'x',
            style: AppTextStyles.heading2.copyWith(
              color: SemanticTextColors.onBrand,
            ),
          ),
        ),
        const Spacer(),
        _CameraCircleButton(
          onTap: () {},
          child: const Icon(
            Icons.flash_off_rounded,
            color: SemanticTextColors.onBrand,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        _CameraCircleButton(
          onTap: () {},
          child: Text(
            'HDR',
            style: AppTextStyles.body1.copyWith(
              color: SemanticTextColors.onBrand,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _ZoomSelector extends StatelessWidget {
  final List<String> options;
  final String selectedZoom;
  final ValueChanged<String> onSelected;

  const _ZoomSelector({
    required this.options,
    required this.selectedZoom,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: options
            .map(
              (option) => GestureDetector(
                onTap: () => onSelected(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: selectedZoom == option
                        ? Colors.white.withOpacity(0.18)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    option,
                    style: AppTextStyles.body1.copyWith(
                      color: selectedZoom == option
                          ? AppColors.primary
                          : SemanticTextColors.onBrand,
                    ),
                  ),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _CameraModeRow extends StatelessWidget {
  const _CameraModeRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: <Widget>[
          Text(
            'Video',
            style: AppTextStyles.body1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            'Portrait',
            style: AppTextStyles.body1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraBottomBar extends StatelessWidget {
  final String previewImagePath;
  final VoidCallback onCapture;

  const _CameraBottomBar({
    required this.previewImagePath,
    required this.onCapture,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipOval(
          child: Image.asset(
            previewImagePath,
            width: 54,
            height: 54,
            fit: BoxFit.cover,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onCapture,
          child: Container(
            width: 74,
            height: 74,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const Spacer(),
        _CameraCircleButton(
          onTap: () {},
          child: const Icon(
            Icons.flip_camera_ios_rounded,
            color: SemanticTextColors.onBrand,
            size: 22,
          ),
        ),
      ],
    );
  }
}

class _CameraCircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _CameraCircleButton({
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 54,
          height: 54,
          child: Center(child: child),
        ),
      ),
    );
  }
}
