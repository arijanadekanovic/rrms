// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rrms/_all.dart';

class ResidenceDetailsPageModel {
  final String title;
  final int id;

  ResidenceDetailsPageModel({
    required this.title,
    required this.id,
  });
}

class ResidenceDetailsPage extends StatelessWidget {
  static const route = '/residence-details';

  final ResidenceDetailsPageModel model;

  const ResidenceDetailsPage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: RRMSAppBar(
        title: model.title,
      ),
      body: ResidenceDetailsContent(id: model.id),
    );
  }
}
