import 'package:rrms/_all.dart';

class ChatMessagesCubit extends EventReaderCubit<ChatMessagesState> {
  final ChatsRepository chatsRepository;

  ChatMessagesCubit({
    required this.chatsRepository,
  }) : super(ChatMessagesState.initial());

  Future<void> load([ChatMessagesSearchRequestModel? searchModel]) async {
    emit(state.copyWith(status: ChatMessagesStateStatus.loading));

    final result = await chatsRepository.getChatMessages(searchModel ?? state.searchModel);

    emit(
      state.copyWith(
        status: ChatMessagesStateStatus.loaded,
        searchModel: searchModel,
        chatMessages: result.data,
      ),
    );
  }

  void _add(ChatMessageResponseModel chatMessage) async {
    print('TRYING TO ADD');

    state.chatMessages?.chatMessages?.add(chatMessage);

    emit(state.copyWith());
  }

  @override
  void onEvent(Object event) {
    if (event is ChatMessageAddState && event.status == ChatMessageAddStateStatus.submittingSuccess) load();
    if (event is PushNotificationsState && event.lastNotification?.chatMessage != null) _add(event.lastNotification!.chatMessage!);
  }
}
