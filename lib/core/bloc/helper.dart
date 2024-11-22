import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class Helper<T> extends Cubit<T?> {
  Helper([super.initialState]);

  void init(T? state) => emit(state);

  void update(T? state) => emit(state);
}

class Handler<T> extends Cubit<T> {
  Handler(super.initialState);

  void init(T state) => emit(state);

  void update(T state) => emit(state);
}

@Injectable()
class TimerHelper extends Cubit<int> {
  TimerHelper([super.initialState = 0]);

  Timer? _timer;

  void start(int timeInSeconds, {Duration duration = const Duration(seconds: 1)}) {
    emit(timeInSeconds);
    _timer?.cancel();
    _timer = Timer.periodic(
      duration,
          (Timer timer) {
        if (timeInSeconds <= 0) {
          cancel.call();
          emit(0);
        } else {
          timeInSeconds = timeInSeconds - duration.inSeconds;
          emit(timeInSeconds);
        }
      },
    );
  }

  void cancel() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
