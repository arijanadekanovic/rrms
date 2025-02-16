import 'package:rrms/_all.dart';

class UserFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialId;
  final void Function(UserResponseModel? city)? onChanged;
  final String? Function(UserResponseModel? city)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? color;
  final Color? borderColor;

  const UserFormField({
    super.key,
    this.label,
    this.hint,
    this.initialId,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, usersState) {
        final selectedUser = usersState.users.firstOrDefault((x) => x.id == initialId);

        return AppDropdownButton(
          label: label,
          hint: hint ?? 'Select user',
          title: selectedUser?.fullName,
          color: color,
          borderColor: borderColor,
          onTap: () {
            showAppDialog(
              context,
              AppDialogModel(
                title: 'Users',
                child: BlocBuilder<UsersCubit, UsersState>(
                  builder: (context, usersState) {
                    if (usersState.status == UsersStateStatus.loading) {
                      return Loader();
                    }

                    if (usersState.users.isNullOrEmpty) {
                      return Center(child: Text('No users'));
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: usersState.users.count,
                      itemBuilder: (context, index) => AppListTile(
                        title: usersState.users[index].fullName ?? '',
                        onTap: () {
                          onChanged?.call(usersState.users[index]);
                          context.pop();
                        },
                      ),
                      separatorBuilder: (context, index) => Line.horizontal(),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
