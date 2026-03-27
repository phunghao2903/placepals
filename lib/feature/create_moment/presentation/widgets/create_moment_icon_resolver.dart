import 'package:flutter/material.dart';

IconData resolveCreateMomentIcon(String key) {
  switch (key) {
    case 'whatshot':
      return Icons.local_fire_department_rounded;
    case 'music_note':
      return Icons.music_note_rounded;
    case 'favorite':
      return Icons.favorite_rounded;
    case 'diamond':
      return Icons.diamond_outlined;
    case 'wifi':
      return Icons.wifi_rounded;
    case 'pets':
      return Icons.pets_rounded;
    case 'deck':
      return Icons.deck_rounded;
    case 'local_bar':
      return Icons.local_bar_rounded;
    case 'add_circle':
      return Icons.add_circle_rounded;
    case 'local_cafe':
      return Icons.local_cafe_rounded;
    case 'park':
      return Icons.park_rounded;
    case 'restaurant':
      return Icons.restaurant_rounded;
    case 'local_library':
      return Icons.local_library_rounded;
    case 'fitness_center':
      return Icons.fitness_center_rounded;
    default:
      return Icons.circle_rounded;
  }
}
