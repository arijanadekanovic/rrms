import 'package:rrms/_all.dart';

class ResidenceDetailsPage extends StatelessWidget {
  static const route = '/residence-details';

  final ResidenceResponseModel residence;

  const ResidenceDetailsPage({
    super.key,
    required this.residence,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: RRMSAppBar(
        title: residence.name,
      ),
      body: ResidenceDetailsContent(residence: residence),
    );
  }
}
