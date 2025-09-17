import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

import '../common/models/failure.dart';
part 'generic_state.dart';

class GenericNotifier<T> extends ChangeNotifier {
  GenericState<T> _state;

  GenericNotifier(T data) : _state = GenericInitialState<T>(data);

  GenericState<T> get state => _state;

  void onUpdateData(T data) {
    _state = GenericUpdatedState<T>(data, !_state.changed);
    notifyListeners();
  }

  void onLoadingState() {
    _state = GenericLoadingState<T>(
      data: _state.data,
      changed: !_state.changed,
    );
    notifyListeners();
  }

  void onDismissLoadingState() {
    _state = GenericDimissLoadingState<T>(
      data: _state.data,
      changed: !_state.changed,
    );
    notifyListeners();
  }

  void onUpdateToInitState(T data) {
    _state = GenericInitialState<T>(data);
    notifyListeners();
  }

  void onErrorState(Failure responseError) {
    _state = GenericErrorState<T>(
      data: _state.data,
      responseError: responseError,
      changed: !_state.changed,
    );
    notifyListeners();
  }
}
