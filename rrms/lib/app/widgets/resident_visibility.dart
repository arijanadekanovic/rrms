import 'package:rrms/_all.dart';

class ResidentVisibility extends StatelessWidget {
  final Widget child;

  const ResidentVisibility({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (!profileState.isResident) {
          return const SizedBox();
        }

        return child;
      },
    );
  }
}
