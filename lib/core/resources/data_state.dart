import 'package:basic_project_template/core/error/database_failure.dart';
import 'package:basic_project_template/core/error/failure.dart';
import 'package:basic_project_template/core/error/generic_failure.dart';

abstract class DataState<T> {
  final T? data;
  final Failure? failure;

  const DataState({this.data, this.failure});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Failure failure) : super(failure: failure);
}

extension DataStateX<T> on DataState<T> {
  bool get isSuccess => this is DataSuccess<T>;

  bool get isFailed => this is DataFailed<T>;

  DataSuccess<T> get asSuccess => this as DataSuccess<T>;

  DataFailed<T> get asFailed => this as DataFailed<T>;

  T? get data => isSuccess ? asSuccess.data : null;

  Failure? get failure => isFailed ? asFailed.failure : null;

  /// handle with when
  void when({
    required void Function(T data) success,
    void Function(Failure failure)? failure,
    void Function(DatabaseFailure failure)? databaseError,
    void Function(GenericFailure failure)? randomError,
  }) {
    if (isSuccess) {
      success(asSuccess.data as T);
    } else if (isFailed) {
      failure?.call(asFailed.failure!);
      if (asFailed.failure! is DatabaseFailure) {
        databaseError?.call(asFailed.failure! as DatabaseFailure);
      }
      if (asFailed.failure! is GenericFailure) {
        randomError?.call(asFailed.failure! as GenericFailure);
      }
    }
  }
}
