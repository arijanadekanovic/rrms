import 'package:rrms/_all.dart';

class ChatGroupsContent extends StatelessWidget {
  const ChatGroupsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocProvider(
        create: (context) => services.get<ChatGroupsCubit>()..load(),
        child: BlocBuilder<ChatGroupsCubit, ChatGroupsState>(
          builder: (context, chatGroupsState) {
            if (chatGroupsState.status == ChatGroupsStateStatus.loading && chatGroupsState.chatGroups.isNullOrEmpty) {
              return Loader();
              // return ChatGroupsShimmer();
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 15),
              itemCount: chatGroupsState.chatGroups.count,
              itemBuilder: (context, index) {
                final chatGroup = chatGroupsState.chatGroups[index];

                return ChatGroupListTile(
                  chatGroup: chatGroup,
                  onTap: () => context.push(
                    ChatMessagesPage.route,
                    extra: ChatMessagesSearchRequestModel(
                      residenceId: chatGroup.residenceId,
                      chatPartnerId: chatGroup.chatPartnerId,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Gap(15),
            );
          },
        ),
      ),
    );
  }
}
