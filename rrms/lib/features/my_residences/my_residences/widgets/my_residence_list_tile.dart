import 'package:rrms/_all.dart';

class MyResidenceListTile extends StatelessWidget {
  final MyResidenceResponseModel myResidence;

  const MyResidenceListTile({
    super.key,
    required this.myResidence,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      // onTap: () => context.push(MyResidenceDetailsPage.route, extra: myResidence),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: context.appTheme.cardBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: CachedImage(
                        url: myResidence.thumbnailUrl,
                        // url: 'https://images.adsttc.com/media/images/5be3/3a40/08a5/e549/e300/0315/newsletter/42442.jpg?1541618191',
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Expanded(child: _ResidenceInfo(myResidence: myResidence)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResidenceInfo extends StatelessWidget {
  final MyResidenceResponseModel myResidence;

  const _ResidenceInfo({
    required this.myResidence,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                myResidence.name.value,
                style: context.textStyle.t14600,
              ),
              Text(
                myResidence.city.value,
                style: context.secondaryTextStyle.t12500,
              ),
              const Gap(5),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ResidenceCharacteristic(
                    icon: Icons.bed_outlined,
                    text: '${myResidence.rooms.value} rooms',
                  ),
                  _ResidenceCharacteristic(
                    icon: Icons.square_foot_outlined,
                    text: '${myResidence.size.formatDecimals().value}m2',
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(5),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            myResidence.rentPrice.formatPriceWithCurrency().value,
            style: context.accentTextStyle.t12500,
          ),
        ),
      ],
    );
  }
}

class _ResidenceCharacteristic extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ResidenceCharacteristic({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: context.secondaryTextStyle.color),
        const Gap(3),
        Text(
          text,
          style: context.secondaryTextStyle.t12500,
        ),
      ],
    );
  }
}
