import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rrms/_all.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  late StreamSubscription _connectivitySubscription;

  ConnectivityCubit() : super(ConnectivityState.initial()) {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((connectivityResults) {
      update(connectivityResults);
    });
  }

  Future<void> update(List<ConnectivityResult> connectivityResults) async {
    emit(state.copyWith(connectivityResults: connectivityResults));
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();

    return super.close();
  }
}
