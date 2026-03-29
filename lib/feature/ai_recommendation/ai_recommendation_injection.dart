import 'package:get_it/get_it.dart';

import 'data/datasources/ai_recommendation_local_datasource.dart';
import 'data/repositories/ai_recommendation_repository_impl.dart';
import 'domain/repositories/ai_recommendation_repository.dart';
import 'domain/usecases/get_ai_recommendation_feed_usecase.dart';
import 'presentation/bloc/ai_recommendation_bloc.dart';

void registerAiRecommendationDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<AiRecommendationLocalDataSource>(
      AiRecommendationLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<AiRecommendationRepository>(
      () => AiRecommendationRepositoryImpl(
        getIt<AiRecommendationLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<GetAiRecommendationFeedUseCase>(
      () => GetAiRecommendationFeedUseCase(getIt<AiRecommendationRepository>()),
    )
    ..registerFactory<AiRecommendationBloc>(
      () => AiRecommendationBloc(
        getAiRecommendationFeedUseCase: getIt<GetAiRecommendationFeedUseCase>(),
      ),
    );
}
