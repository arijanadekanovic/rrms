import 'package:rrms/_all.dart';

class ChatMessageAddCubit extends EventProviderCubit<ChatMessageAddState> {
  final ChatsRepository chatsRepository;

  ChatMessageAddCubit({
    required this.chatsRepository,
  }) : super(ChatMessageAddState.initial());

  void init(ChatMessageAddRequestModel model) {
    emit(state.copyWith(model: model));
  }

  void update(ChatMessageAddRequestModel model) {
    emit(state.copyWith(model: model));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: ChatMessageAddStateStatus.submitting));

    final result = await chatsRepository.addChatMessage(state.model);

    if (result.isSuccess) {
      emit(state.copyWith(status: ChatMessageAddStateStatus.submittingSuccess));
      state.model.messageText = '';
    } else {
      emit(state.copyWith(status: ChatMessageAddStateStatus.submittingError));
    }

    emit(state.copyWith(status: ChatMessageAddStateStatus.initial));
  }
}
