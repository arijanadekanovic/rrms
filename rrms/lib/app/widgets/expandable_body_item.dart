import 'package:rrms/_all.dart';

class ExpandableBodyItem extends StatelessWidget {
  final String? title;
  final String? text;
  final Color? textColor;
  final Widget? child;

  const ExpandableBodyItem({
    super.key,
    this.title,
    this.text,
    this.textColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (child == null && text.isNullOrEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title.isNotNullOrEmpty) ...{
            Expanded(
              child: Text(
                title.value,
                style: context.textStyle.t14600.withColor(const Color(0xFF78829D)),
              ),
            ),
            const Gap(10),
          },
          if (text.isNotNullOrEmpty)
            Text(
              text.value,
              style: context.textStyle.t14500.withColor(textColor ?? context.textStyle.color),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
