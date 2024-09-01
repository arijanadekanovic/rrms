import 'package:rrms/_all.dart';
import 'package:rrms/features/payments/payments/cubit/payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  final PaymentsRepository paymentsRepository;

  PaymentsCubit({
    required this.paymentsRepository,
  }) : super(PaymentsState.initial());

  Future<void> loadPayments() async {
    emit(state.copyWith(status: PaymentsStateStatus.processing));

    try {
      final result = await paymentsRepository.get();
      emit(
        state.copyWith(
          status: PaymentsStateStatus.success,
          payments: result.data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentsStateStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}