import 'package:bloc/bloc.dart';
import 'package:bloc_practice/null/Task%20App/model/task_model.dart';
import 'package:bloc_practice/null/Task%20App/repository/task_reporesitory.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;
  TaskBloc(this._taskRepository) : super(const TaskLoaded()) {
    on<LoadTasks>(_onLoadTask);

    on<AddTasks>(
      (event, emit) {
        final state = this.state;
        if (state is TaskLoaded) {
          emit(
            TaskLoaded(
              tasks: List.from(state.tasks)..add(event.task),
            ),
          );
        }
      },
    );
    on<DeleteTasks>(
      ((event, emit) {
        final state = this.state;
        if (state is TaskLoaded) {
          List<Task> tasks = state.tasks.where((task) {
            return task.id != event.task.id;
          }).toList();
          emit(TaskLoaded(tasks: tasks));
        }
      }),
    );
    on<UpdateTasks>(
      ((event, emit) {
        final state = this.state;
        if (state is TaskLoaded) {
          List<Task> tasks = (state.tasks.map((task) {
            return task.id == event.task.id ? event.task : task;
          })).toList();
          emit(TaskLoaded(tasks: tasks));
        }
      }),
    );
  }
  Future<void> _onLoadTask(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await _taskRepository.getTask();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
