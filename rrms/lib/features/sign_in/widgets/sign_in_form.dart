import 'package:rrms/_all.dart';

class SignInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<SignInCubit>(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, signInState) {
          if (signInState.status == SignInStateStatus.validationError) {
            _formKey.validate();
          }
        },
        builder: (context, signInState) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextFormField(
                  label: 'Username',
                  onChanged: (text) => context.read<SignInCubit>().update(
                        signInState.model.copyWith(
                          emailOrUserName: text,
                        ),
                      ),
                  validator: (text) => signInState.modelValidator.emailOrUserName(signInState.model.copyWith(emailOrUserName: text)),
                ),
                const Gap(10),
                AppPasswordTextFormField(
                  label: 'Password',
                  onChanged: (text) => context.read<SignInCubit>().update(
                        signInState.model.copyWith(
                          password: text,
                        ),
                      ),
                  validator: (text) => signInState.modelValidator.password(signInState.model.copyWith(password: text)),
                ),
                const Gap(30),
                Button(
                  text: 'Sign in',
                  onTap: () => context.read<SignInCubit>().submit(),
                  primary: true,
                  isLoading: signInState.status == SignInStateStatus.submitting,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
