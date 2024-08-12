import 'package:rrms/_all.dart';

class ProfileUpdatePage extends StatelessWidget {
  static const route = '/profile-update';

  const ProfileUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: RRMSAppBar(
        title: 'Profile update',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: ProfileUpdateForm(),
      ),
    );
  }
}
