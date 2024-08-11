import 'package:rrms/_all.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocProvider(
        create: (context) => services.get<ProfileCubit>(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            if (profileState.status == ProfileStateStatus.loading) {
              return Loader();
            }

            if (profileState.accountDetails == null) {
              return Center(child: Text('No data'));
            }

            final accountDetails = profileState.accountDetails!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedImage(
                      url: accountDetails.profilePhotoUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const Gap(20),
                InfoListTile(
                  label: 'Name',
                  text: '${accountDetails.firstName} ${accountDetails.lastName}',
                ),
                InfoListTile(
                  label: 'Email',
                  text: accountDetails.email,
                ),
                InfoListTile(
                  label: 'Username',
                  text: accountDetails.username,
                ),
                InfoListTile(
                  label: 'Phone number',
                  text: accountDetails.phoneNumber,
                ),
                InfoListTile(
                  label: 'Role(s)',
                  text: accountDetails.roles?.join(', '),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
