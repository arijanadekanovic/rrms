import 'package:rrms/_all.dart';

class ResidentStatusUpdateActions extends StatelessWidget {
  final ResidentResponseModel resident;

  ResidentStatusUpdateActions({
    super.key,
    required this.resident,
  });

  @override
  Widget build(BuildContext context) {
    if (resident.status != ResidentStatus.pendingRequest) {
      return const SizedBox();
    }

    return Column(
      children: [
        const Gap(20),
        BlocProvider(
          create: (context) => services.get<ResidentStatusUpdateCubit>(),
          child: BlocConsumer<ResidentStatusUpdateCubit, ResidentStatusUpdateState>(
            listener: (context, residentStatusUpdateState) {
              if (residentStatusUpdateState.status == ResidentStatusUpdateStateStatus.submittingSuccess) {
                toast.success('Successfully updated status to: ${residentStatusUpdateState.model?.status?.title}');
              }
            },
            builder: (context, residentStatusUpdateState) {
              return Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Accept',
                      textStyle: context.textStyle.t16600,
                      primary: true,
                      isLoading: residentStatusUpdateState.model?.status == ResidentStatus.active && residentStatusUpdateState.status == ResidentStatusUpdateStateStatus.submitting,
                      lean: true,
                      onTap: () => context.read<ResidentStatusUpdateCubit>().submit(
                            ResidentStatusUpdateRequestModel(
                              residentId: resident.id,
                              status: ResidentStatus.active,
                            ),
                          ),
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: Button(
                      text: 'Reject',
                      textStyle: context.textStyle.t16600,
                      secondary: true,
                      isLoading: residentStatusUpdateState.model?.status == ResidentStatus.rejected && residentStatusUpdateState.status == ResidentStatusUpdateStateStatus.submitting,
                      loaderColor: context.appTheme.accentColor,
                      lean: true,
                      onTap: () => context.read<ResidentStatusUpdateCubit>().submit(
                            ResidentStatusUpdateRequestModel(
                              residentId: resident.id,
                              status: ResidentStatus.rejected,
                            ),
                          ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
