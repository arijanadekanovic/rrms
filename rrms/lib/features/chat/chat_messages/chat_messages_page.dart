import 'package:rrms/_all.dart';

class ChatMessagesPage extends StatelessWidget {
  static const route = '/chat-messages';
  final ChatMessagesSearchRequestModel searchModel;

  const ChatMessagesPage({
    super.key,
    required this.searchModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<ChatMessagesCubit>()..load(searchModel),
      child: AppScaffold(
        appBar: BlocBuilder<ChatMessagesCubit, ChatMessagesState>(
          builder: (context, chatMessagesState) {
            if (chatMessagesState.chatMessages != null) {
              return RRMSAppBar(
                child: Row(
                  children: [
                    CachedImage(
                      url: chatMessagesState.chatMessages?.chatPartnerProfilePictureUrl,
                      height: 30,
                      width: 30,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    const Gap(10),
                    Text(
                      chatMessagesState.chatMessages?.chatPartnerName ?? '',
                      style: context.textStyle.t16600.withColor(Colors.white),
                    ),
                  ],
                ),
              );
            }

            return RRMSAppBar(
              title: 'Chat messages',
            );
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<ChatMessagesCubit, ChatMessagesState>(
              builder: (context, chatMessagesState) {
                // if (chatMessagesState.status == ChatMessagesStateStatus.loading && (chatMessagesState.chatMessages?.chatMessages).isNullOrEmpty) {
                //   return Loader();
                //   // return ChatMessagesShimmer();
                // }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: (chatMessagesState.chatMessages?.chatMessages).count,
                        itemBuilder: (context, index) {
                          final chatMessage = chatMessagesState.chatMessages?.chatMessages?[index];

                          if (chatMessage == null) {
                            return const SizedBox();
                          }

                          return ChatMessageTile(chatMessage: chatMessage);
                        },
                        separatorBuilder: (BuildContext context, int index) => const Gap(15),
                      ),
                    ),
                    MessageFormField(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MessageFormField extends StatelessWidget {
  const MessageFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: AppTextFormField(
              hint: 'Type a message',
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: context.appTheme.blue,
            ),
          ),
        ],
      ),
    );
  }
}
