import 'package:rrms/_all.dart';

class ResidenceDeleteButton extends StatelessWidget {
  final int id;

  ResidenceDeleteButton({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<ResidenceDeleteCubit>(),
      child: BlocConsumer<ResidenceDeleteCubit, ResidenceDeleteState>(
        listener: (context, residenceDeleteState) {
          if (residenceDeleteState.status == ResidenceDeleteStateStatus.submittingSuccess) {
            toast.success('Successfully deleted residence');
            context.pop();
          }
        },
        builder: (context, residenceDeleteState) {
          return IconButton(
            onPressed: () => showConfirmationAppDialog(
              context,
              onOkay: () => context.read<ResidenceDeleteCubit>().submit(id),
            ),
            icon: () {
              if (residenceDeleteState.status == ResidenceDeleteStateStatus.submitting) {
                return Loader.sm(color: Colors.white);
              }

              return Icon(
                Icons.delete,
                color: context.appTheme.danger,
              );
            }(),
          );
        },
      ),
    );
  }
}
