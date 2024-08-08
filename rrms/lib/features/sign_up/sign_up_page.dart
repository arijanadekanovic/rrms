import 'package:rrms/_all.dart';

class SignUpPage extends StatelessWidget {
  static const String route = '/sign-up';

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            const Gap(20),
            Text(
              'Sign up for an account in RRMS',
              style: context.textStyle.t32600,
            ),
            const Gap(30),
            SignUpForm(),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
