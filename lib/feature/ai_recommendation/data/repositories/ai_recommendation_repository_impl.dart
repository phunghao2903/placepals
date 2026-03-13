import '../../domain/entities/ai_recommendation_feed.dart';
import '../../domain/repositories/ai_recommendation_repository.dart';
import '../datasources/ai_recommendation_local_datasource.dart';

class AiRecommendationRepositoryImpl implements AiRecommendationRepository {
  final AiRecommendationLocalDataSource localDataSource;

  const AiRecommendationRepositoryImpl(this.localDataSource);

  @override
  Future<AiRecommendationFeed> getAiRecommendationFeed() async {
    final feed = await localDataSource.getAiRecommendationFeed();
    return feed.toEntity();
  }
}
