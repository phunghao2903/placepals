import 'failures.dart';

sealed class Result<T> {
  const Result();

  R fold<R>(R Function(Failure failure) onFailure, R Function(T value) onSuccess);
}

final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);

  @override
  R fold<R>(R Function(Failure failure) onFailure, R Function(T value) onSuccess) {
    return onSuccess(value);
  }
}

final class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);

  @override
  R fold<R>(R Function(Failure failure) onFailure, R Function(T value) onSuccess) {
    return onFailure(failure);
  }
}
