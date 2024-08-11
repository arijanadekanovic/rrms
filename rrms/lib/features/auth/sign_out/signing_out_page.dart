import 'package:rrms/_all.dart';

class SigningOutPage extends StatelessWidget {
  const SigningOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: []),
              Text(
                'Signing you out',
                style: context.textStyle.t24600,
              ),
              Text(
                'It won\'t take long...',
                style: context.secondaryTextStyle.t18500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
