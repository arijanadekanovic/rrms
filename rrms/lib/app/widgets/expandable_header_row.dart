// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rrms/_all.dart';

class ExpandableHeaderRow extends StatelessWidget {
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final List<ExpandableHeaderRowTitle>? titles;
  final List<Widget>? items;

  const ExpandableHeaderRow({
    super.key,
    this.color,
    this.padding,
    this.titles = const [],
    this.items = const [],
  }) : assert(titles != null || items != null, 'titles or items must be provided');

  @override
  Widget build(BuildContext context) {
    return ExpandableRow(
      padding: const EdgeInsets.only(left: 20, right: 65),
      color: color ?? const Color(0xFFF9F9F9),
      items: titles
              ?.map<Widget>(
                (x) => Text(
                  x.text,
                  style: context.secondaryTextStyle.t14600.withColor(const Color(0xFF78829D)),
                  overflow: TextOverflow.ellipsis,
                  textAlign: x.textAlign,
                ),
              )
              .toList() ??
          items ??
          [],
    );
  }
}

class ExpandableHeaderRowTitle {
  final String text;
  final TextAlign textAlign;

  const ExpandableHeaderRowTitle({
    required this.text,
    this.textAlign = TextAlign.start,
  });
}
