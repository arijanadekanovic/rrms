import 'package:rrms/_all.dart';

class ResidencesHistoryListTile extends StatelessWidget {
  final ResidencesHistoryResponseModel residencesHistory;

  const ResidencesHistoryListTile({
    super.key,
    required this.residencesHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
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
                        url: residencesHistory.thumbnailUrl,
                        // url: 'https://images.adsttc.com/media/images/5be3/3a40/08a5/e549/e300/0315/newsletter/42442.jpg?1541618191',
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
               Expanded(child: _ResidencesHistoryInfo(residencesHistory: residencesHistory)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResidencesHistoryInfo extends StatelessWidget {
  final ResidencesHistoryResponseModel residencesHistory;

  const _ResidencesHistoryInfo({
    required this.residencesHistory,
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
                residencesHistory.name.value,
                style: context.textStyle.t14600,
              ),
              Text(
                residencesHistory.city.value,
                style: context.secondaryTextStyle.t12500,
              ),
              const Gap(5),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ResidenceCharacteristic(
                    icon: Icons.bed_outlined,
                    text: '${residencesHistory.rooms.value} rooms',
                  ),
                  _ResidenceCharacteristic(
                    icon: Icons.square_foot_outlined,
                    text: '${residencesHistory.size.formatDecimals().value}m2',
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
            residencesHistory.rentPrice.formatPriceWithCurrency().value,
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
