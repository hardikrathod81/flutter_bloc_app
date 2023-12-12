import 'package:bloc_practice/null/Album%20Api%20call%20by%20bloc/model.dart';
import 'package:bloc_practice/null/Album%20Api%20call%20by%20bloc/reporestriy.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends HydratedBloc<CommentsEvent, CommentsState> {
  AlbumAPiCall albumApicall = AlbumAPiCall();
  CommentsBloc() : super(CommentsInitial()) {
    on<CommentLoadedEvent>((event, emit) async {
      try {
        return emit(CommentsLoadeState(album: await albumApicall.fetchData()));
      } catch (e) {
        throw Exception(e);
      }
    });
  }

  @override
  CommentsState fromJson(Map<String, dynamic> json) {
    try {
      return CommentsLoadeState(album: List<Album>.from(json['album']));
    } catch (_) {
      return CommentsInitial();
    }
  }

  @override
  Map<String, dynamic> toJson(CommentsState state) {
    if (state is CommentsLoadeState) {
      return {'album': state.album};
    }
    return {};
  }
}
