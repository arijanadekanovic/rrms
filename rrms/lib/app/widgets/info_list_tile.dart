import 'package:rrms/_all.dart';

class InfoListTile extends StatelessWidget {
  final String? label;
  final String? text;
  final Widget? child;
  final EdgeInsetsGeometry padding;

  const InfoListTile({
    super.key,
    this.label,
    this.text,
    this.child,
    this.padding = const EdgeInsets.only(bottom: 20),
  });

  @override
  Widget build(BuildContext context) {
    if (child == null && text.isNullOrEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.value,
            style: context.secondaryTextStyle.t14500,
          ),
          const Gap(5),
          child ??
              Text(
                text.value,
                style: context.textStyle.t14500,
              ),
        ],
      ),
    );
  }
}
