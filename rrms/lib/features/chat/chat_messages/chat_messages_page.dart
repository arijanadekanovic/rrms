import 'package:rrms/_all.dart';

class ChatMessagesPage extends StatefulWidget {
  static const route = '/chat-messages';
  final ChatMessagesSearchRequestModel searchModel;

  ChatMessagesPage({
    super.key,
    required this.searchModel,
  });

  @override
  State<ChatMessagesPage> createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<ChatMessagesCubit>()..load(widget.searchModel),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocConsumer<ChatMessagesCubit, ChatMessagesState>(
            listener: (context, chatMessagesState) {
              if (chatMessagesState.status == ChatMessagesStateStatus.loaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) => scrollController.jumpTo(scrollController.position.maxScrollExtent));
              }
            },
            builder: (context, chatMessagesState) {
              // if (chatMessagesState.status == ChatMessagesStateStatus.loading && (chatMessagesState.chatMessages?.chatMessages).isNullOrEmpty) {
              //   return Loader();
              //   // return ChatMessagesShimmer();
              // }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      padding: EdgeInsets.only(bottom: 15),
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
                  ChatMessageAddFormField(
                    chatPartnerId: widget.searchModel.chatPartnerId.value,
                    residenceId: widget.searchModel.residenceId.value,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
