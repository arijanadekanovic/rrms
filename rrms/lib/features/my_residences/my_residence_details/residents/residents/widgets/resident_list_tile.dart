import 'package:rrms/_all.dart';

class ResidentListTile extends StatelessWidget {
  final ResidentResponseModel resident;

  const ResidentListTile({
    super.key,
    required this.resident,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.appTheme.cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  resident.userFullName.value,
                  style: context.textStyle.t14600,
                ),
              ),
              Text(
                resident.status?.title ?? '',
                style: context.textStyle.t14600.withColor(resident.status?.color(context.appTheme) ?? Colors.black),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: Text(
                  resident.contractStartDate.format(),
                  style: context.textStyle.t14500,
                ),
              ),
              Text(
                resident.contractEndDate.format(),
                style: context.textStyle.t14500,
              ),
            ],
          ),
          ResidentStatusUpdateActions(resident: resident),
        ],
      ),
    );
  }
}
