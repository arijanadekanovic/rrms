import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityState {
  List<ConnectivityResult> connectivityResults;

  ConnectivityState({
    required this.connectivityResults,
  });

  factory ConnectivityState.initial() => ConnectivityState(connectivityResults: [ConnectivityResult.none]);

  ConnectivityState copyWith({
    List<ConnectivityResult>? connectivityResults,
  }) =>
      ConnectivityState(
        connectivityResults: connectivityResults ?? this.connectivityResults,
      );
}
