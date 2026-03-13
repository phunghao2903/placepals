import '../entities/ai_recommendation_feed.dart';

abstract class AiRecommendationRepository {
  Future<AiRecommendationFeed> getAiRecommendationFeed();
}
