import 'package:rrms/_all.dart';

class ChatMessageAddFormField extends StatefulWidget {
  final String chatPartnerId;
  final int residenceId;

  const ChatMessageAddFormField({
    super.key,
    required this.chatPartnerId,
    required this.residenceId,
  });

  @override
  State<ChatMessageAddFormField> createState() => _ChatMessageAddFormFieldState();
}

class _ChatMessageAddFormFieldState extends State<ChatMessageAddFormField> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: BlocProvider(
        create: (context) => services.get<ChatMessageAddCubit>()
          ..init(
            ChatMessageAddRequestModel(
              chatPartnerId: widget.chatPartnerId,
              residenceId: widget.residenceId,
            ),
          ),
        child: BlocConsumer<ChatMessageAddCubit, ChatMessageAddState>(
          listener: (context, chatMessageAddState) {
            if (chatMessageAddState.status == ChatMessageAddStateStatus.submittingSuccess) {
              textEditingController.clear();
            }
          },
          builder: (context, chatMessageAddState) {
            return Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    hint: 'Type a message',
                    controller: textEditingController,
                    onChanged: (text) => context.read<ChatMessageAddCubit>().update(chatMessageAddState.model.copyWith(messageText: text)),
                  ),
                ),
                Button(
                  onTap: () {
                    if (chatMessageAddState.model.messageText.isNotNullOrEmpty) {
                      context.read<ChatMessageAddCubit>().submit();
                    }
                  },
                  child: Icon(
                    Icons.send,
                    color: context.appTheme.blue,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
