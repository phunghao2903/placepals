import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get h => screenSize.height;
  double get w => screenSize.width;
  double get topPadding => MediaQuery.paddingOf(this).top;
}
