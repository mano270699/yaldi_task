part of 'generic_notifier.dart';

abstract class GenericState<T> extends Equatable {
  final T data;
  final bool changed;
  final Failure? responseError;

  const GenericState({
    required this.data,
    required this.changed,
    this.responseError,
  });
}

class GenericInitialState<T> extends GenericState<T> {
  const GenericInitialState(T data)
    : super(data: data, changed: false, responseError: null);

  @override
  List<Object?> get props => [changed];
}

class GenericLoadingState<T> extends GenericState<T> {
  const GenericLoadingState({required super.data, required super.changed});

  @override
  List<Object?> get props => [changed];
}

class GenericDimissLoadingState<T> extends GenericState<T> {
  const GenericDimissLoadingState({
    required super.data,
    required super.changed,
  });

  @override
  List<Object?> get props => [changed];
}

class GenericUpdatedState<T> extends GenericState<T> {
  const GenericUpdatedState(T data, bool changed)
    : super(data: data, changed: changed, responseError: null);

  @override
  List<Object?> get props => [changed];
}

class GenericErrorState<T> extends GenericState<T> {
  const GenericErrorState({
    required super.data,
    required Failure super.responseError,
    required super.changed,
  });

  @override
  List<Object?> get props => [changed];
}
