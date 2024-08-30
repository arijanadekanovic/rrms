import 'package:rrms/_all.dart';

class ResidentsShimmer extends StatelessWidget {
  const ResidentsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: AppShimmer.generate(
        10,
        AppShimmer(140, context.screenWidth, 10),
        15,
      ),
    );
  }
}
