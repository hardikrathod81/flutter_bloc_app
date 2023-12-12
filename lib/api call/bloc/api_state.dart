part of 'api_bloc.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiInitial extends ApiState {}

class ApiLoadingState extends ApiState {}

class ApiLoadedState extends ApiState {
  final List<PersonDataBase> person;

  const ApiLoadedState({required this.person});

  @override
  List<Object> get props => [person];
}

class ApiFailedState extends ApiState {
  final String errormessege;

  const ApiFailedState({required this.errormessege});

  @override
  List<Object> get props => [errormessege];
}
