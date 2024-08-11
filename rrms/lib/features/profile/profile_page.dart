import 'package:rrms/_all.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: RRMSAppBar(
        title: 'Profile',
        primary: true,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Push profile edit page here
            },
            icon: Icon(Icons.edit),
          ),
          const Gap(10),
        ],
      ),
      body: ListView(
        children: [
          ProfileInfo(),
          Line.horizontal(),
          SignOutListTile(),
        ],
      ),
    );
  }
}
