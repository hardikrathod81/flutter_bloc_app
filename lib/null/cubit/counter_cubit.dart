import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends HydratedCubit<CounterState> {
  CounterCubit() : super(const CounterState(countervalue: 0));

  void increment() => emit(
      CounterState(countervalue: state.countervalue + 1, wasincrement: true));
  void decrement() => emit(
      CounterState(countervalue: state.countervalue - 1, wasincrement: false));

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState(
        countervalue: json['countervalue'] as int,
        wasincrement: json['wasincrement'] as bool);
  }

  @override
  Map<String, dynamic>? toJson(state) {
    return {
      'countervalue': state.countervalue,
      'wasincrement': state.wasincrement
    };
  }
}
