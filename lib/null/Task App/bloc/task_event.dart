part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends TaskEvent {}

class LoadTasks extends TaskEvent {
  final List<Task> tasks;

  const LoadTasks({this.tasks = const <Task>[]});
  @override
  List<Object> get props => [tasks];
}

class AddTasks extends TaskEvent {
  final Task task;

  const AddTasks({required this.task});
  @override
  List<Object> get props => [task];
}

class UpdateTasks extends TaskEvent {
  final Task task;

  const UpdateTasks({required this.task});
  @override
  List<Object> get props => [task];
}

class DeleteTasks extends TaskEvent {
  final Task task;

  const DeleteTasks({required this.task});
  @override
  List<Object> get props => [task];
}
