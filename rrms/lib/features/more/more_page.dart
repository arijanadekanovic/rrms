import 'package:rrms/_all.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: RRMSAppBar(
        title: 'More',
        primary: true,
      ),
      body: ListView(
        children: [
          ProfileInfo(),
        ],
      ),
    );
  }
}
