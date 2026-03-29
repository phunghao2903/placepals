import 'package:flutter/material.dart';

IconData resolveMapSearchIcon(String key) {
  switch (key) {
    case 'local_cafe':
      return Icons.local_cafe_rounded;
    case 'park':
      return Icons.park_rounded;
    case 'restaurant':
      return Icons.restaurant_rounded;
    case 'local_bar':
      return Icons.local_bar_rounded;
    case 'local_library':
      return Icons.local_library_rounded;
    default:
      return Icons.location_on_rounded;
  }
}
