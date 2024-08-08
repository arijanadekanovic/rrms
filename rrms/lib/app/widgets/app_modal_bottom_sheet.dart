import 'package:rrms/_all.dart';

Future<bool?> showAppModalBottomSheet(
  BuildContext context,
  AppModalBottomSheetModel model,
) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: model.barrierColor,
    constraints: BoxConstraints(
      minHeight: model.minHeight ?? 0,
      maxHeight: model.maxHeight ?? context.screenHeight * 0.9,
    ),
    builder: (context) => AppModalBottomSheet(model: model),
  );
}

class AppModalBottomSheet extends StatelessWidget {
  final AppModalBottomSheetModel model;

  const AppModalBottomSheet({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    Widget getTitle() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: context.appTheme.neutral,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  if (model.useCancelIcon)
                    model.cancelIcon ??
                        IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            color: context.textStyle.color,
                            size: 30,
                          ),
                          onPressed: () => context.pop(),
                        ),
                  Expanded(
                    child: Text(
                      model.title.value,
                      style: context.textStyle.t18700,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (model.useCancelIcon && model.actions.isNullOrEmpty) const Gap(50),
                  if (model.actions.isNotNullOrEmpty) ...model.actions!,
                ],
              ),
            ],
          ),
        );

    final listChild = Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ListView(
        shrinkWrap: true,
        children: [
          if (model.title.isNotNullOrEmpty) getTitle(),
          if (model.title.isNullOrEmpty && model.useCancelIcon)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: context.secondaryTextStyle.color,
                      size: 30,
                    ),
                    onPressed: () => context.pop(),
                  ),
                ),
              ],
            ),
          if (model.child != null) model.child!,
        ],
      ),
    );

    final columnChild = Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        children: [
          if (model.title.isNotNullOrEmpty) getTitle(),
          if (model.child != null) Expanded(child: model.child!),
        ],
      ),
    );

    final child = model.shrinkWrap ? columnChild : listChild;

    return model.providerBuilder?.call(child) ?? child;
  }
}

class AppModalBottomSheetModel {
  final String? title;
  final bool useCancelIcon;
  final Widget? cancelIcon;
  final bool shrinkWrap;
  final Widget? child;
  final List<Widget>? actions;
  final double? minHeight;
  final double? maxHeight;
  final Color? barrierColor;
  final Widget Function(Widget child)? providerBuilder;

  AppModalBottomSheetModel({
    this.title,
    this.useCancelIcon = true,
    this.cancelIcon,
    this.shrinkWrap = false,
    this.child,
    this.providerBuilder,
    this.actions,
    this.minHeight,
    this.maxHeight,
    this.barrierColor,
  });
}
