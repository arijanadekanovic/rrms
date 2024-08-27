import 'package:rrms/_all.dart';

class ResidenceUpdatePage extends StatelessWidget {
  static const String route = '/residence-update';

  final int id;

  const ResidenceUpdatePage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RRMSAppBar(
        title: 'Update residence',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            ResidenceUpdateForm(id: id),
          ],
        ),
      ),
    );
  }
}
