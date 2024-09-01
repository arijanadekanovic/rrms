import 'package:rrms/_all.dart';

enum ChatMessageAddStateStatus {
  initial,
  initialSubmitted,
  submitting,
  submittingSuccess,
  submittingError,
  validationError,
}

class ChatMessageAddState extends Event {
  final ChatMessageAddStateStatus status;
  final ChatMessageAddRequestModel model;

  ChatMessageAddState({
    required this.status,
    required this.model,
  });

  factory ChatMessageAddState.initial() => ChatMessageAddState(
        status: ChatMessageAddStateStatus.initial,
        model: ChatMessageAddRequestModel(),
      );

  ChatMessageAddState copyWith({
    ChatMessageAddStateStatus? status,
    ChatMessageAddRequestModel? model,
  }) {
    return ChatMessageAddState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
