import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:counter_bloc/src/counter_event.dart';
import 'package:counter_bloc/src/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int counter = 0;
  CounterBloc() : super(InitialState()) {
    on<NumberIncreaseEvent>(onNumberIncrease);
    on<NumberDecreaseEvent>(onNumberDecrease);
  }

  void onNumberIncrease(
      NumberIncreaseEvent event, Emitter<CounterState> emit) async {
    counter += 1;
    emit(UpdateState(counter));
  }

  void onNumberDecrease(
      NumberDecreaseEvent event, Emitter<CounterState> emit) async {
    counter -= 1;
    emit(UpdateState(counter));
  }
}
