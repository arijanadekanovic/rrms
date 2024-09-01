import 'package:rrms/_all.dart';

enum ChatMessagesStateStatus {
  loading,
  loaded,
}

class ChatMessagesState {
  final ChatMessagesStateStatus status;
  final ChatMessagesSearchRequestModel searchModel;
  final ChatMessagesResponseModel? chatMessages;

  ChatMessagesState({
    required this.status,
    required this.searchModel,
    this.chatMessages,
  });

  factory ChatMessagesState.initial() => ChatMessagesState(
        status: ChatMessagesStateStatus.loaded,
        searchModel: ChatMessagesSearchRequestModel(),
      );

  ChatMessagesState copyWith({
    ChatMessagesStateStatus? status,
    ChatMessagesSearchRequestModel? searchModel,
    ChatMessagesResponseModel? chatMessages,
  }) {
    return ChatMessagesState(
      status: status ?? this.status,
      searchModel: searchModel ?? this.searchModel,
      chatMessages: chatMessages ?? this.chatMessages,
    );
  }
}
