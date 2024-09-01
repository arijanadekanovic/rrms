import 'package:rrms/_all.dart';

class PaymentsCubit extends EventReaderCubit<PaymentsState> {
  final PaymentsRepository paymentsRepository;

  PaymentsCubit({
    required this.paymentsRepository,
  }) : super(PaymentsState.initial());

  Future<void> load([PaymentSearchRequestModel? searchModel]) async {
    emit(state.copyWith(status: PaymentsStateStatus.loading));

    final result = await paymentsRepository.get(searchModel ?? state.searchModel);

    emit(
      state.copyWith(
        status: PaymentsStateStatus.loaded,
        searchModel: searchModel,
        payments: result.data,
      ),
    );
  }

  @override
  void onEvent(Object event) {
    if (event is PaymentAddState && event.status == PaymentAddStateStatus.submittingSuccess) load();
  }
}
