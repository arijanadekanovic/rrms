import 'package:rrms/_all.dart';

class ExpandableRow extends StatelessWidget {
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final List<Widget> items;
  final MainAxisAlignment? mainAxisAlignment;

  const ExpandableRow({
    super.key,
    this.color,
    this.padding,
    this.items = const [],
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? context.appTheme.cardBackgroundColor,
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: items
            .mapIndexed(
              (index, item) => Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(child: item),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
