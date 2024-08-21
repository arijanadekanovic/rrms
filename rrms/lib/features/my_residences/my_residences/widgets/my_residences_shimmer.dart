import 'package:rrms/_all.dart';

class MyResidencesShimmer extends StatelessWidget {
  const MyResidencesShimmer({
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
