import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rrms/_all.dart';

class ConnectivityAppWidgetListener extends StatelessWidget {
  final Widget child;

  const ConnectivityAppWidgetListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, connectivityState) {
        return Column(
          children: [
            if (connectivityState.connectivityResults.contains(ConnectivityResult.none)) ...{
              Material(
                color: Colors.transparent,
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translations.no_internet_connection,
                        style: context.textStyle.t16500.withColor(Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            },
            Expanded(child: child),
          ],
        );
      },
    );
  }
}
