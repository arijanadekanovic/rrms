import 'package:rrms/_all.dart';

class ResidenceRecommendationListTile extends StatelessWidget {
  final ResidenceRecommendationResponseModel residence;
  final void Function()? onTap;

  const ResidenceRecommendationListTile({
    super.key,
    required this.residence,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: () => context.push(
        ResidenceDetailsPage.route,
        extra: ResidenceDetailsPageModel(
          title: residence.name.value,
          id: residence.id.value,
        ),
      ),
      child: SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              url: residence.thumbnailUrl.value,
              fit: BoxFit.cover,
              height: 200,
              width: 250,
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    residence.name.value,
                    style: context.textStyle.t14600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Gap(10),
            Text(
              'Price: ${residence.rentPrice.formatPriceWithCurrency()}',
              style: context.textStyle.t14500,
            ),
          ],
        ),
      ),
    );
  }
}
