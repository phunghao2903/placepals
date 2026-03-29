import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/place_details_bloc.dart';
import 'place_detail_page.dart';

class PlaceDetailsFeaturePage extends StatelessWidget {
  final String placeId;

  const PlaceDetailsFeaturePage({
    super.key,
    required this.placeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlaceDetailsBloc>(
      create: (_) => getIt<PlaceDetailsBloc>()
        ..add(PlaceDetailsStarted(placeId: placeId)),
      child: const PlaceDetailPage(),
    );
  }
}
