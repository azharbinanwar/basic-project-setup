import 'package:flutter_bloc/flutter_bloc.dart';

class Helper<T> extends Cubit<T?> {
  Helper([super.initialState]);

  void init(T? state) => emit(state);

  void update(T? state) => emit(state);
}
