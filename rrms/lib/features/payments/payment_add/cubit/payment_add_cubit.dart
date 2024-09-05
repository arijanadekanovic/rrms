import 'package:rrms/_all.dart';

class PaymentAddCubit extends EventProviderCubit<PaymentAddState> {
  final PaymentsRepository paymentsRepository;

  PaymentAddCubit({
    required this.paymentsRepository,
  }) : super(PaymentAddState.initial());

  void init(PaymentAddRequestModel model) {
    emit(state.copyWith(model: model));
  }

  void update(PaymentAddRequestModel model) {
    emit(state.copyWith(model: model));
  }

  Future<void> submit([PaymentAddRequestModel? model]) async {
    emit(state.copyWith(status: PaymentAddStateStatus.submitting));

    final result = await paymentsRepository.add(model ?? state.model);

    if (result.isSuccess) {
      emit(state.copyWith(status: PaymentAddStateStatus.submittingSuccess));
    } else {
      emit(state.copyWith(status: PaymentAddStateStatus.submittingError));
    }
  }
}
