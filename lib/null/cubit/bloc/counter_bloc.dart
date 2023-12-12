import 'package:bloc/bloc.dart';
import 'package:bloc_practice/null/cubit/bloc/counter_state.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterStatesss> {
  CounterBloc() : super(const Initial()) {
    on<Incremnt>((vent, emit) {
      emit(CounterStatesss(state.count + 1));
    });
    on<Decremnt>((event, emit) {
      emit(CounterStatesss(state.count - 1));
    });
  }
}
