part of 'comments_bloc.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class CommentsLodingState extends CommentsState {}

class CommentsLoadeState extends CommentsState {
  final List<Album> album;

  const CommentsLoadeState({required this.album});
  @override
  List<Object> get props => [album];
}

class CommentsFailed extends CommentsState {
  final String error;

  const CommentsFailed({required this.error});
  @override
  List<Object> get props => [error];
}
