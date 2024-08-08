import 'package:rrms/_all.dart';

class SignInFooter extends StatelessWidget {
  const SignInFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'or create a new account',
          style: context.textStyle.t14500,
          textAlign: TextAlign.center,
        ),
        const Gap(20),
        Button(
          text: 'Sign up',
          onTap: () => context.push(SignUpPage.route),
          secondary: true,
        ),
      ],
    );
  }
}
