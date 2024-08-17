import 'package:rrms/_all.dart';

enum PaymentsStateStatus {
  initial,
  processing,
  success,
  failure,
}

class PaymentsState {
  final PaymentsStateStatus status;
  final List<PaymentResponseModel> payments;
  final String? errorMessage;

  PaymentsState({
    required this.status,
    this.payments = const [],
    this.errorMessage,
  });

  PaymentsState copyWith({
    PaymentsStateStatus? status,
    List<PaymentResponseModel>? payments,
    String? errorMessage,
  }) {
    return PaymentsState(
      status: status ?? this.status,
      payments: payments ?? this.payments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory PaymentsState.initial() {
    return PaymentsState(
      status: PaymentsStateStatus.initial,
      payments: [],
      errorMessage: null,
    );
  }
}
