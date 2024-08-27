import 'package:rrms/_all.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: RRMSAppBar(
        title: 'Chats',
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          ChatListTile(),
          const Gap(10),
          ChatListTile(),
        ],
      ),
    );
  }
}
