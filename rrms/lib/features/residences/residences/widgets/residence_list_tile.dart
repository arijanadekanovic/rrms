import 'package:rrms/_all.dart';

class ResidenceListTile extends StatelessWidget {
  final ResidenceResponseModel residence;
  final void Function()? onTap;

  const ResidenceListTile({
    super.key,
    required this.residence,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: context.appTheme.cardBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 124,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: CachedImage(
                        url: residence.thumbnailUrl,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Expanded(child: _ResidenceInfo(residence: residence)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResidenceInfo extends StatelessWidget {
  final ResidenceResponseModel residence;

  const _ResidenceInfo({
    required this.residence,
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
              Text(
                residence.city.value,
                style: context.secondaryTextStyle.t12500,
              ),
              const Gap(5),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ResidenceCharacteristic(
                    icon: Icons.bed_outlined,
                    text: '${residence.rooms.value} rooms',
                  ),
                  _ResidenceCharacteristic(
                    icon: Icons.square_foot_outlined,
                    text: '${residence.size.formatDecimals().value}m2',
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
            residence.rentPrice.formatPriceWithCurrency().value,
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
