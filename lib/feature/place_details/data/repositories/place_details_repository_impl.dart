import '../../domain/entities/place_details_feed.dart';
import '../../domain/repositories/place_details_repository.dart';
import '../datasources/place_details_local_datasource.dart';

class PlaceDetailsRepositoryImpl implements PlaceDetailsRepository {
  final PlaceDetailsLocalDataSource localDataSource;

  const PlaceDetailsRepositoryImpl(this.localDataSource);

  @override
  Future<PlaceDetailsFeed> getPlaceDetailsFeed(String placeId) async {
    final model = await localDataSource.getPlaceDetailsFeed(placeId);
    return model.toEntity();
  }
}
