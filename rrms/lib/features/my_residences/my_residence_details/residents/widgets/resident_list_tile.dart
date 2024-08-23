import 'package:rrms/_all.dart';

class ResidentListTile extends StatelessWidget {
  final ResidentResponseModel resident;
  final void Function()? onTap;

  const ResidentListTile({
    super.key,
    required this.resident,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final DateTime? contractStartDate;
    // final DateTime? contractEndDate;
    // final ResidentStatus? status;
    // final String? userFullName;

    return Clickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
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
            )
          ],
        ),
      ),
    );
  }
}
