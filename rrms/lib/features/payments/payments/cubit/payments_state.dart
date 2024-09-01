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
  final bool isImageUploadInProgress;

  PaymentsState({
    required this.status,
    this.payments = const [],
    this.errorMessage,
    this.isImageUploadInProgress = false,
  });

  PaymentsState copyWith({
    PaymentsStateStatus? status,
    List<PaymentResponseModel>? payments,
    String? errorMessage,
    bool? isImageUploadInProgress,
  }) {
    return PaymentsState(
      status: status ?? this.status,
      payments: payments ?? this.payments,
      errorMessage: errorMessage ?? this.errorMessage,
      isImageUploadInProgress: isImageUploadInProgress ?? this.isImageUploadInProgress,
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
