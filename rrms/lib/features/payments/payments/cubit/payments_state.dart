import 'package:rrms/_all.dart';

enum PaymentsStateStatus {
  loading,
  loaded,
}

class PaymentsState {
  final PaymentsStateStatus status;
  final PaymentSearchRequestModel searchModel;
  final List<PaymentResponseModel> payments;
  final String? errorMessage;
  final bool isImageUploadInProgress;

  PaymentsState({
    required this.status,
    required this.searchModel,
    this.payments = const [],
    this.errorMessage,
    this.isImageUploadInProgress = false,
  });

  factory PaymentsState.initial() {
    return PaymentsState(
      status: PaymentsStateStatus.loading,
      searchModel: PaymentSearchRequestModel(),
      payments: [],
      errorMessage: null,
    );
  }

  PaymentsState copyWith({
    PaymentsStateStatus? status,
    PaymentSearchRequestModel? searchModel,
    List<PaymentResponseModel>? payments,
    String? errorMessage,
    bool? isImageUploadInProgress,
  }) {
    return PaymentsState(
      status: status ?? this.status,
      searchModel: searchModel ?? this.searchModel,
      payments: payments ?? this.payments,
      errorMessage: errorMessage ?? this.errorMessage,
      isImageUploadInProgress: isImageUploadInProgress ?? this.isImageUploadInProgress,
    );
  }
}
