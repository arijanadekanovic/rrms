import 'package:rrms/_all.dart';
import 'package:rrms/features/payments/payments/cubits/payments_state.dart';

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

  Future<void> processPayment(double amount) async {
    emit(state.copyWith(status: PaymentsStateStatus.processing));

    try {
      final result = await paymentsRepository.processPayment(amount);
      emit(
        state.copyWith(
          status: PaymentsStateStatus.success,
          payments: state.payments + [result.data!],
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
