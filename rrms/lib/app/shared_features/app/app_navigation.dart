import 'package:rrms/_all.dart';

class AppNavigation extends StatelessWidget {
  static const route = '/';

  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignOutCubit, SignOutState>(
      builder: (context, signOutState) {
        if (signOutState.status == SignOutStateStatus.submitting) {
          return const SigningOutPage();
        }

        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, authState) {
            if (authState.status == AuthStateStatus.unAuthenticated) {
              return context.popToBottom();
            }
          },
          builder: (context, authState) {
            if (authState.status == AuthStateStatus.authenticated) {
              return const Home();
            }

            return SignInPage();
          },
        );
      },
    );
  }
}
