import 'package:rrms/_all.dart';

Future<bool> showRequestRationale(Permission permission) async {
  return await showDefaultRequestRationale(
    permission,
    PermissionRationaleMessages.basic(
      description: translations.application_needs_permission_to_continue_this_action,
    ),
  );
}

Future<bool> showDefaultRequestRationale(Permission permission, PermissionRationaleMessages messages) async {
  if (appRouter.context == null) {
    return false;
  }

  final context = appRouter.context!;

  return await showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  messages.title,
                  style: context.textStyle.t20600,
                ),
              ),
              const Line.horizontal(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messages.description,
                      style: context.textStyle.t16600,
                    ),
                    const Gap(10),
                    if (messages.additionalDescription.isNotNullOrEmpty)
                      Text(
                        messages.additionalDescription.value,
                        style: context.secondaryTextStyle.t12500,
                      ),
                    Text(
                      messages.actionDescription,
                      style: context.secondaryTextStyle.t12500,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onTap: () => context.pop(false),
                      transparent: true,
                      text: messages.cancel,
                      textColor: context.secondaryTextStyle.color,
                    ),
                    Button(
                      onTap: () {
                        openAppSettings();
                        context.pop(false);
                      },
                      primary: true,
                      text: messages.okay,
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
}
