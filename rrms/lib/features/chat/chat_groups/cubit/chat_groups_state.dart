import 'package:rrms/_all.dart';

enum ChatGroupsStateStatus {
  loading,
  loaded,
}

class ChatGroupsState {
  final ChatGroupsStateStatus status;
  final List<ChatGroupResponseModel> chatGroups;

  ChatGroupsState({
    required this.status,
    required this.chatGroups,
  });

  factory ChatGroupsState.initial() => ChatGroupsState(
        status: ChatGroupsStateStatus.loaded,
        chatGroups: [],
      );

  ChatGroupsState copyWith({
    ChatGroupsStateStatus? status,
    List<ChatGroupResponseModel>? chatGroups,
  }) {
    return ChatGroupsState(
      status: status ?? this.status,
      chatGroups: chatGroups ?? this.chatGroups,
    );
  }
}
