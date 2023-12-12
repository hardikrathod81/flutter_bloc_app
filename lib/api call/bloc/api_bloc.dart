import 'package:bloc_practice/api%20call/hive/database.dart';
import 'package:bloc_practice/api%20call/services/network_call.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final PersonNetworkService personNetworkService = PersonNetworkService();
  final PersonNetwoek personNetwoek = PersonNetwoek();
  ApiBloc() : super(ApiInitial()) {
    on<APiLoadingEvent>((event, emit) async {
      try {
        emit(ApiLoadingState());
        final hasConnected = await Connectivity().checkConnectivity();
        if (hasConnected == ConnectivityResult.mobile ||
            hasConnected == ConnectivityResult.wifi) {
          final serverResponse = await personNetwoek.fetchPersonData();
          await personNetwoek.savePostsLocally(posts: serverResponse);
          final localPosts = await personNetwoek.fetchAllLocalPosts();
          emit(ApiLoadedState(person: localPosts.toList()));
        } else {
          final localPosts = await personNetwoek.fetchAllLocalPosts();
          emit(ApiLoadedState(person: localPosts));
        }
      } catch (e) {
        emit(ApiFailedState(errormessege: e.toString()));
      }
    });
    on<ApiFailed>(
        (event, emit) => const ApiFailedState(errormessege: 'this wrong'));
  }
}
