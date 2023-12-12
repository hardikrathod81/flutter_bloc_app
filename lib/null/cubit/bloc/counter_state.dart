import 'package:equatable/equatable.dart';

class CounterStatesss extends Equatable {
  final int count;

  const CounterStatesss(this.count);

  @override
  List<Object> get props => [count];
}

class Initial extends CounterStatesss {
  const Initial() : super(0);
}
