# Kien truc & Mau thiet ke

Du an duoc to chuc theo Feature-first + Clean Architecture:

- presentation: UI + State management (BLoC)
- domain: entities, repository contracts, use cases
- data: datasource, models, repository implementations

Luon phu thuoc chinh:
UI -> Bloc -> UseCase -> Repository (interface) -> RepositoryImpl -> DataSource (Firebase/API/local)

Dependency Injection dung GetIt voi mo hinh dang ky theo tung feature qua cac file *_injection.dart, gom tai lib/core/di/injector.dart.
