import 'package:expandable/expandable.dart';
import 'package:rrms/_all.dart';

enum ExpandableIconPlacement {
  left,
  right,
}

class Expandable extends StatefulWidget {
  final Widget Function(bool isExpanded)? headerBuilder;
  final Widget? header;
  final Widget? body;
  final Color? collapseIconColor;
  final Color? expandIconColor;
  final IconData? collapseIcon;
  final IconData? expandIcon;
  final double? iconSize;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsets? iconPadding;
  final ExpandableIconPlacement iconPlacement;
  final Color? headerColorExpanded;
  final Color? headerColorCollapsed;
  final bool isInitiallyExpanded;
  final bool hasIcon;
  final bool tapHeaderToExpand;
  final bool useInkWell;

  const Expandable({
    super.key,
    this.headerBuilder,
    this.header,
    required this.body,
    this.collapseIconColor,
    this.expandIconColor,
    this.collapseIcon,
    this.expandIcon,
    this.iconSize = 24.0,
    this.color,
    this.padding,
    this.headerPadding,
    this.iconPadding,
    this.iconPlacement = ExpandableIconPlacement.right,
    this.headerColorExpanded,
    this.headerColorCollapsed,
    this.isInitiallyExpanded = false,
    this.hasIcon = true,
    this.tapHeaderToExpand = true,
    this.useInkWell = true,
  }) : assert(headerBuilder != null || header != null, 'headerBuilder or header must be provided');

  @override
  State<Expandable> createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> {
  final ExpandableController? controller = ExpandableController();

  @override
  void initState() {
    super.initState();

    if (widget.isInitiallyExpanded && !(controller?.expanded ?? false)) {
      controller?.toggle();
    }
    controller?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHeaderExpanded = controller?.expanded ?? false;
    final headerColor = isHeaderExpanded ? widget.headerColorExpanded : widget.headerColorCollapsed;

    return Container(
      color: headerColor,
      padding: widget.padding ?? EdgeInsets.zero,
      child: ExpandablePanel(
        controller: controller,
        theme: ExpandableThemeData(
          tapBodyToCollapse: false,
          iconRotationAngle: 0.0,
          tapHeaderToExpand: widget.tapHeaderToExpand,
          useInkWell: widget.useInkWell,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          iconPlacement: widget.iconPlacement == ExpandableIconPlacement.right ? ExpandablePanelIconPlacement.right : ExpandablePanelIconPlacement.left,
          iconColor: (isHeaderExpanded ? widget.expandIconColor : widget.collapseIconColor) ?? context.appTheme.accentColor,
          hasIcon: widget.hasIcon,
          collapseIcon: widget.collapseIcon,
          expandIcon: widget.expandIcon,
          iconSize: widget.iconSize,
          iconPadding: widget.iconPadding ?? const EdgeInsets.all(20),
        ),
        header: Container(
          color: headerColor ?? context.theme.cardColor,
          padding: widget.headerPadding,
          child: widget.header ?? widget.headerBuilder?.call(isHeaderExpanded),
        ),
        expanded: widget.body ?? const SizedBox(),
        collapsed: const SizedBox(),
      ),
    );
  }
}
