import 'package:rrms/_all.dart';

class ResidentAddForm extends StatelessWidget {
  final int residenceId;

  const ResidentAddForm({
    super.key,
    required this.residenceId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: BlocProvider(
        create: (context) => services.get<ResidentAddCubit>()..init(residenceId),
        child: BlocConsumer<ResidentAddCubit, ResidentAddState>(
          listener: (context, residentAddState) {
            if (residentAddState.status == ResidentAddStateStatus.submittingSuccess) {
              toast.success('You have successfully requested for rent!');
              context.pop();
            }
          },
          builder: (context, residentAddState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your rental dates:',
                  style: context.textStyle.t16500,
                ),
                const Gap(20),
                AppDateFormField(
                  label: 'Start date',
                  initialValue: residentAddState.model.contractStartDate,
                  borderColor: context.secondaryTextStyle.color,
                  onChanged: (date) => context.read<ResidentAddCubit>().update(residentAddState.model.copyWith(contractStartDate: date)),
                  validator: (data) => residentAddState.modelValidator.contractStartDate(residentAddState.model.copyWith(contractStartDate: data)),
                ),
                const Gap(15),
                AppDateFormField(
                  label: 'End date',
                  initialValue: residentAddState.model.contractEndDate,
                  borderColor: context.secondaryTextStyle.color,
                  onChanged: (date) => context.read<ResidentAddCubit>().update(residentAddState.model.copyWith(contractEndDate: date)),
                  validator: (data) => residentAddState.modelValidator.contractEndDate(residentAddState.model.copyWith(contractEndDate: data)),
                ),
                const Gap(40),
                Row(
                  children: [
                    Expanded(
                      child: Button(
                        text: 'Send request',
                        textStyle: context.textStyle.t16600,
                        primary: true,
                        padding: EdgeInsets.all(6),
                        isLoading: residentAddState.status == ResidentAddStateStatus.submitting,
                        onTap: () => context.read<ResidentAddCubit>().submit(),
                      ),
                    ),
                    const Gap(15),
                    Expanded(
                      child: Button(
                        text: 'Cancel',
                        textStyle: context.textStyle.t16600,
                        secondary: true,
                        padding: EdgeInsets.all(6),
                        onTap: () => context.pop(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
