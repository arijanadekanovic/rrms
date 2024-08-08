import 'package:rrms/_all.dart';

class ErrorHandlerAppWidgetListener extends StatelessWidget {
  final Widget child;

  const ErrorHandlerAppWidgetListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorHandlerCubit, ErrorHandlerState>(
      listener: (context, errorHandlerState) {
        if (errorHandlerState.showMessage) {
          toast.showExceptionMessage(errorHandlerState.exception!);
        }
      },
      child: child,
    );
  }
}
