import 'package:rrms/_all.dart';

class PermissionHandlerBuilder extends StatelessWidget {
  final Permission permission;
  final Widget Function(BuildContext context, void Function() onRequest) initialBuilder;
  final Widget Function(BuildContext context) allowedBuilder;
  final Widget Function(BuildContext context, void Function() onRequest) deniedBuilder;
  final Widget Function(BuildContext context, void Function() onRequest) deniedForeverBuilder;

  final bool autoInit;

  final void Function(PermissionHandlerState permissionHandlerState)? initialListener;
  final void Function(PermissionHandlerState permissionHandlerState)? allowedListener;
  final void Function(PermissionHandlerState permissionHandlerState)? deniedListener;
  final void Function(PermissionHandlerState permissionHandlerState)? deniedForeverListener;

  const PermissionHandlerBuilder({
    super.key,
    required this.permission,
    required this.initialBuilder,
    required this.allowedBuilder,
    required this.deniedBuilder,
    required this.deniedForeverBuilder,
    this.autoInit = true,
    this.initialListener,
    this.allowedListener,
    this.deniedListener,
    this.deniedForeverListener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<PermissionHandlerCubit>(param1: permission),
      child: StatefulBuilder(
        builder: (context, _) {
          return BlocConsumer<PermissionHandlerCubit, PermissionHandlerState>(
            listener: (context, permissionHandlerState) {
              switch (permissionHandlerState.status) {
                case PermissionHandlerStateStatus.initial:
                  if (initialListener != null) {
                    initialListener?.call(permissionHandlerState);
                  } else {
                    if (autoInit) {
                      context.read<PermissionHandlerCubit>().request();
                    }
                  }
                  break;
                case PermissionHandlerStateStatus.allowed:
                  allowedListener?.call(permissionHandlerState);
                  break;
                case PermissionHandlerStateStatus.denied:
                  deniedListener?.call(permissionHandlerState);
                  break;
                case PermissionHandlerStateStatus.deniedForever:
                  deniedForeverListener?.call(permissionHandlerState);
                  break;
              }
            },
            builder: (context, permissionHandlerState) {
              switch (permissionHandlerState.status) {
                case PermissionHandlerStateStatus.initial:
                  return initialBuilder(
                    context,
                    () => context.read<PermissionHandlerCubit>().request(),
                  );
                case PermissionHandlerStateStatus.allowed:
                  return allowedBuilder(context);
                case PermissionHandlerStateStatus.denied:
                  return deniedBuilder(
                    context,
                    () => context.read<PermissionHandlerCubit>().request(),
                  );
                case PermissionHandlerStateStatus.deniedForever:
                  return deniedForeverBuilder(
                    context,
                    () => context.read<PermissionHandlerCubit>().openSettings(),
                  );
              }
            },
          );
        },
      ),
    );
  }
}
