import 'package:rrms/_all.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const RRMSAppBar(
        title: 'Chats',
        primary: true,
      ),
      body: Padding(
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
                  return ChatGroupListTile(
                    chatGroup: chatGroupsState.chatGroups[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Gap(15),
              );
            },
          ),
        ),
      ),
    );
  }
}
