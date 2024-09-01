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
              return Column(
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: const Text(
                          'Browse your payment slip',
                          style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: Button(
                          text: 'Submit',
                          primary: true,
                          isLoading: paymentAddState.status == PaymentAddStateStatus.submitting,
                          onTap: () => context.read<PaymentAddCubit>().submit(),
                        ),
                      )),
                  const Gap(20),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
