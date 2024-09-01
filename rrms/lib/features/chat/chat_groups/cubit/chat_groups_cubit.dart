import 'package:rrms/_all.dart';

class ChatGroupsCubit extends EventReaderCubit<ChatGroupsState> {
  final ChatsRepository chatsRepository;

  ChatGroupsCubit({
    required this.chatsRepository,
  }) : super(ChatGroupsState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ChatGroupsStateStatus.loading));

    final result = await chatsRepository.getChatGroups();

    emit(
      state.copyWith(
        status: ChatGroupsStateStatus.loaded,
        chatGroups: result.data,
      ),
    );
  }

  @override
  void onEvent(Object event) {
    if (event is ChatMessageAddState && event.status == ChatMessageAddStateStatus.submittingSuccess) load();
  }
}
