import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? streamSubscription;
  InternetCubit() : super(InternetInitState()) {
    streamSubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.mobile ||
            event == ConnectivityResult.wifi) {
          emit(InterGainedState());
        } else {
          emit(InterLostState());
        }
      },
    );
  }
  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
