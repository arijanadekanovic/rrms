import 'package:rrms/_all.dart';

class ProfileUpdateForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ProfileUpdateForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<ProfileUpdateCubit>()..init(),
      child: BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
        listener: (context, profileUpdateState) {
          if (profileUpdateState.status == ProfileUpdateStateStatus.submittingSuccess) {
            toast.success('You have successfully updated your profile!');
            context.pop();
          }

          if (profileUpdateState.status == ProfileUpdateStateStatus.validationError) {
            _formKey.validate();
          }
        },
        builder: (context, profileUpdateState) {
          if (profileUpdateState.status == ProfileUpdateStateStatus.initializing) {
            return Loader();
          }

          return Form(
            key: _formKey,
            autovalidateMode: profileUpdateState.autovalidateMode,
            child: Column(
              children: [
                const Gap(10),
                AppTextFormField(
                  label: 'First name',
                  initialValue: profileUpdateState.model?.firstName,
                  onChanged: (text) => context.read<ProfileUpdateCubit>().update(
                        profileUpdateState.model?.copyWith(
                          firstName: text,
                        ),
                      ),
                  validator: (text) => profileUpdateState.modelValidator.firstName(profileUpdateState.model?.copyWith(firstName: text)),
                ),
                const Gap(20),
                AppTextFormField(
                  label: 'Last name',
                  initialValue: profileUpdateState.model?.lastName,
                  onChanged: (text) => context.read<ProfileUpdateCubit>().update(
                        profileUpdateState.model?.copyWith(
                          lastName: text,
                        ),
                      ),
                  validator: (text) => profileUpdateState.modelValidator.lastName(profileUpdateState.model?.copyWith(lastName: text)),
                ),
                const Gap(20),
                AppTextFormField(
                  label: 'Phone number',
                  initialValue: profileUpdateState.model?.phoneNumber,
                  onChanged: (text) => context.read<ProfileUpdateCubit>().update(
                        profileUpdateState.model?.copyWith(
                          phoneNumber: text,
                        ),
                      ),
                  validator: (text) => profileUpdateState.modelValidator.phoneNumber(profileUpdateState.model?.copyWith(phoneNumber: text)),
                ),
                const Gap(30),
                Button(
                  text: 'Save',
                  onTap: () => context.read<ProfileUpdateCubit>().submit(),
                  primary: true,
                  isLoading: profileUpdateState.status == ProfileUpdateStateStatus.submitting,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
