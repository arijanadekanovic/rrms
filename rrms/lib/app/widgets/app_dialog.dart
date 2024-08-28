import 'package:rrms/_all.dart';

Future<bool?> showAppDialog(
  BuildContext context,
  AppDialogModel model,
) async {
  return await showDialog(
    context: context,
    builder: (context) => AppDialog(model: model),
  );
}

Future<bool?> showConfirmationAppDialog(
  BuildContext context, {
  Widget Function(Widget)? providerBuilder,
  void Function()? onOkay,
}) async {
  return await showAppDialog(
    context,
    AppDialogModel(
      title: translations.confirmation,
      description: translations.are_you_sure_that_you_want_to_proceed_questionmark,
      cancelText: translations.no,
      okayText: translations.yes,
      onCancel: () => context.pop(),
      onOkay: () {
        onOkay?.call();
        context.pop();
      },
      useCancelIcon: false,
    ),
  );
}

class AppDialog extends StatelessWidget {
  final AppDialogModel model;

  const AppDialog({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final content = model.child ??
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                model.description.value,
                style: context.textStyle.t16600,
                textAlign: TextAlign.center,
              ),
              if (model.additionalDescription.isNotNullOrEmpty) ...{
                const Gap(10),
                Text(
                  model.additionalDescription.value,
                  style: context.secondaryTextStyle.t12500,
                ),
              },
            ],
          ),
        );

    final child = StatefulBuilder(
      builder: (context, snapshot) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(model.borderRadius),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(model.borderRadius),
            ),
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (model.showHeader)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            model.title.value,
                            style: context.textStyle.t18500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (model.useCancelIcon)
                          IconButton(
                            onPressed: () => context.pop(),
                            icon: Icon(
                              Icons.close,
                              size: 16,
                              color: context.secondaryTextStyle.color,
                            ),
                          ),
                      ],
                    ),
                  ),
                if (model.showTitle) const Line.horizontal(),
                model.scrollable ? Expanded(child: SingleChildScrollView(child: content)) : content,
                if (model.showActions) const Line.horizontal(),
                if (model.showActions) const Gap(10),
                if (model.showActions)
                  model.action ??
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (model.showOkay)
                              Expanded(
                                child: Button(
                                  onTap: () => model.onOkay?.call(),
                                  primary: true,
                                  text: model.okayText ?? translations.okay,
                                ),
                              ),
                            if (model.showCancel) const Gap(10),
                            if (model.showCancel)
                              Expanded(
                                child: Button(
                                  onTap: () => model.onCancel?.call(),
                                  transparent: true,
                                  text: model.cancelText ?? translations.cancel,
                                  textColor: context.primaryTextStyle.color,
                                ),
                              ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );

    return model.providerBuilder?.call(child) ?? child;
  }
}

class AppDialogModel {
  final String? title;
  final String? description;
  final String? additionalDescription;
  final String? cancelText;
  final bool useCancelIcon;
  final String? okayText;
  final Widget? child;
  final bool scrollable;
  final Widget? action;
  final double borderRadius;

  final Widget Function(Widget child)? providerBuilder;
  final void Function()? onCancel;
  final void Function()? onOkay;

  bool get showActions => showCancel || showOkay || action != null;
  bool get showHeader => title.isNotNullOrEmpty || useCancelIcon;
  bool get showTitle => title.isNotNullOrEmpty;
  bool get showCancel => (cancelText.isNotNullOrEmpty || onCancel != null) && !useCancelIcon && action == null;
  bool get showOkay => (okayText.isNotNullOrEmpty || onOkay != null) && action == null;

  AppDialogModel({
    this.title,
    this.description,
    this.additionalDescription,
    this.cancelText,
    this.useCancelIcon = true,
    this.okayText,
    this.child,
    this.scrollable = false,
    this.providerBuilder,
    this.onCancel,
    this.onOkay,
    this.action,
    this.borderRadius = 10.0,
  });
}
