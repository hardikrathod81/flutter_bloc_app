part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int countervalue;
  final bool? wasincrement;

  const CounterState({required this.countervalue, this.wasincrement});

  @override
  List<Object?> get props => [countervalue, wasincrement];
}
