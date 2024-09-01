import 'package:rrms/_all.dart';

enum PaymentAddStateStatus {
  initializing,
  initialized,
  initialSubmitted,
  submitting,
  submittingSuccess,
  submittingError,
  validationError,
}

class PaymentAddState extends Event {
  final PaymentAddStateStatus status;
  final PaymentAddRequestModel model;

  PaymentAddState({
    required this.status,
    required this.model,
  });

  factory PaymentAddState.initial() => PaymentAddState(
        status: PaymentAddStateStatus.initializing,
        model: PaymentAddRequestModel(),
      );

  PaymentAddState copyWith({
    PaymentAddStateStatus? status,
    PaymentAddRequestModel? model,
  }) {
    return PaymentAddState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
