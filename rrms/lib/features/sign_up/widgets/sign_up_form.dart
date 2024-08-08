import 'package:rrms/_all.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<SignUpCubit>(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, signUpState) {
          if (signUpState.status == SignUpStateStatus.submittingSuccess) {
            toast.success('You have successfully created an account!');
            context.popToBottom();
          }

          if (signUpState.status == SignUpStateStatus.validationError) {
            _formKey.validate();
          }
        },
        builder: (context, signUpState) {
          return Form(
            key: _formKey,
            autovalidateMode: signUpState.autovalidateMode,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: () {
                        final isSelected = signUpState.model.role == AppRole.resident;

                        return Button(
                          text: AppRole.resident.title,
                          textStyle: context.textStyle.t14500,
                          onTap: () => context.read<SignUpCubit>().update(
                                signUpState.model.copyWith(
                                  role: AppRole.resident,
                                ),
                              ),
                          primary: isSelected,
                          secondary: !isSelected,
                        );
                      }(),
                    ),
                    const Gap(10),
                    Expanded(
                      child: () {
                        final isSelected = signUpState.model.role == AppRole.landlord;

                        return Button(
                          text: AppRole.landlord.title,
                          textStyle: context.textStyle.t14500,
                          onTap: () => context.read<SignUpCubit>().update(
                                signUpState.model.copyWith(
                                  role: AppRole.landlord,
                                ),
                              ),
                          primary: isSelected,
                          secondary: !isSelected,
                        );
                      }(),
                    ),
                  ],
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Email',
                  onChanged: (text) => context.read<SignUpCubit>().update(
                        signUpState.model.copyWith(
                          email: text,
                        ),
                      ),
                  validator: (text) => signUpState.modelValidator.email(signUpState.model.copyWith(email: text)),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Username',
                  onChanged: (text) => context.read<SignUpCubit>().update(
                        signUpState.model.copyWith(
                          username: text,
                        ),
                      ),
                  validator: (text) => signUpState.modelValidator.username(signUpState.model.copyWith(username: text)),
                ),
                const Gap(10),
                AppPasswordTextFormField(
                  label: 'Password',
                  onChanged: (text) => context.read<SignUpCubit>().update(
                        signUpState.model.copyWith(
                          password: text,
                        ),
                      ),
                  validator: (text) => signUpState.modelValidator.password(signUpState.model.copyWith(password: text)),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'First name',
                  onChanged: (text) => context.read<SignUpCubit>().update(
                        signUpState.model.copyWith(
                          firstName: text,
                        ),
                      ),
                  validator: (text) => signUpState.modelValidator.firstName(signUpState.model.copyWith(firstName: text)),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Last name',
                  onChanged: (text) => context.read<SignUpCubit>().update(
                        signUpState.model.copyWith(
                          lastName: text,
                        ),
                      ),
                  validator: (text) => signUpState.modelValidator.lastName(signUpState.model.copyWith(lastName: text)),
                ),
                const Gap(30),
                Button(
                  text: 'Sign up',
                  onTap: () => context.read<SignUpCubit>().submit(),
                  primary: true,
                  isLoading: signUpState.status == SignUpStateStatus.submitting,
                ),
                const Gap(10),
                Button(
                  text: 'Cancel',
                  onTap: () => context.pop(),
                  secondary: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
