import '../entities/ai_recommendation_feed.dart';
import '../repositories/ai_recommendation_repository.dart';

class GetAiRecommendationFeedUseCase {
  final AiRecommendationRepository repository;

  const GetAiRecommendationFeedUseCase(this.repository);

  Future<AiRecommendationFeed> call() {
    return repository.getAiRecommendationFeed();
  }
}
