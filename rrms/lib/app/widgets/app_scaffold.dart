import 'package:rrms/_all.dart';

class AppScaffold extends StatelessWidget {
  final Widget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          if (appBar != null) appBar!,
          if (body != null) Expanded(child: body!),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
