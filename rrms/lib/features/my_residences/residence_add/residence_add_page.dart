import 'package:rrms/_all.dart';

class ResidenceAddPage extends StatelessWidget {
  static const String route = '/residence-add';

  const ResidenceAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RRMSAppBar(
        title: 'Add residence',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            ResidenceAddForm(),
          ],
        ),
      ),
    );
  }
}
