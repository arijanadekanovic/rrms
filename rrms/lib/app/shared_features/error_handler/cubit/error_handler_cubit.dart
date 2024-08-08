import 'package:rrms/_all.dart';

class ErrorHandlerCubit extends Cubit<ErrorHandlerState> {
  final RestApiClient restApiClient;
  late StreamSubscription _restApiClientSubscription;

  ErrorHandlerCubit({
    required this.restApiClient,
  }) : super(ErrorHandlerState(status: ErrorHandlerStateStatus.clean)) {
    _restApiClientSubscription = restApiClient.exceptionHandler.exceptions.stream.listen((exception) {
      addNewException(exception);
    });
  }

  Future<void> addNewException(BaseException exception) async {
    emit(
      ErrorHandlerState(
        status: ErrorHandlerStateStatus.dirty,
        exception: exception,
      ),
    );
  }

  @override
  Future<void> close() {
    _restApiClientSubscription.cancel();

    return super.close();
  }
}
