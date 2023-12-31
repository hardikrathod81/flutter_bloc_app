part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitState extends InternetState {}

class InterLostState extends InternetState {}

class InterGainedState extends InternetState {}
