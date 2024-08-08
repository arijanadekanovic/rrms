import 'package:rrms/_all.dart';

class MoreButton extends StatelessWidget {
  final void Function()? onTap;

  const MoreButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.secondaryTextStyle.color, width: 2),
        ),
        child: Icon(
          Icons.more_vert,
          color: context.secondaryTextStyle.color,
          size: 22,
        ),
      ),
    );
  }
}
