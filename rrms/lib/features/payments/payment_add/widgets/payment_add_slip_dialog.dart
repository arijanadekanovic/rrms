import 'package:file_picker/file_picker.dart';
import 'package:rrms/_all.dart';

class PaymentAddDialog extends StatelessWidget {
  const PaymentAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        final amount = profileState.accountDetails?.residentInfo?.residencePrice ?? 0;
        final residentId = profileState.accountDetails?.residentInfo?.residentId ?? 0;

        return BlocProvider(
          create: (context) => services.get<PaymentAddCubit>()
            ..init(
              PaymentAddRequestModel(
                amount: amount,
                residentId: residentId,
                paymentMethod: PaymentMethod.slip,
              ),
            ),
          child: BlocConsumer<PaymentAddCubit, PaymentAddState>(
            listener: (context, paymentAddState) {
              if (paymentAddState.status == PaymentAddStateStatus.submittingSuccess) {
                toast.success('Successfully added a new payment slip');
                context.pop();
              }
            },
            builder: (context, paymentAddState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Amount: ${amount.formatPrice()}\$',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Gap(15),
                    MediaPickerButton(
                      onMediaTaken: (items) {
                        final fileInfo = items.firstOrDefault();
                        if (fileInfo != null) {
                          context.read<PaymentAddCubit>().update(paymentAddState.model.copyWith(slip: fileInfo));
                        }
                      },
                      type: MediaPickerButtonType.file,
                      fileConfig: MediaPickerFileConfig(
                        fileType: FileType.custom,
                        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
                      ),
                      allowMultiple: false,
                      child: Button(
                        secondary: true,
                        text: paymentAddState.model.slip == null ? 'Choose file' : 'Choose another file',
                      ),
                    ),
                    if (paymentAddState.model.slip != null) ...[
                      const Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              paymentAddState.model.slip?.name ?? '',
                              style: context.textStyle.t14500,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const Gap(20),
                    Button(
                      text: 'Submit',
                      primary: true,
                      isLoading: paymentAddState.status == PaymentAddStateStatus.submitting,
                      onTap: () => context.read<PaymentAddCubit>().submit(),
                    ),
                    const Gap(20),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
