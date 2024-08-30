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
      body: ChatGroupsContent(),
    );
  }
}
