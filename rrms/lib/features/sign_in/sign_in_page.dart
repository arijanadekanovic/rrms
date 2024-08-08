import 'package:rrms/_all.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Gap(20),
                    Text(
                      'Sign into your RRMS account',
                      style: context.textStyle.t32600,
                    ),
                    const Gap(30),
                    SignInForm(),
                    const Gap(30),
                  ],
                ),
              ),
              const Gap(20),
              SignInFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
