import 'package:rrms/_all.dart';
import 'package:rrms/features/payments/payments/widgets/payments_history.dart';
import 'package:rrms/features/payments/payments/widgets/payments_options_modal.dart';
import 'package:rrms/features/payments/payments/widgets/payments_paypal_screen.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentsCubit(
        paymentsRepository: services.get<PaymentsRepository>(),
      )..loadPayments(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pay your rent'),
        ),
        body: BlocBuilder<PaymentsCubit, PaymentsState>(
          builder: (context, state) {
            if (state.status == PaymentsStateStatus.processing) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == PaymentsStateStatus.failure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else if (state.status == PaymentsStateStatus.success && state.payments.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.payments.length,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    onTap: () => _showPaymentOptions(context),
                    payment: state.payments[index],
                  );
                },
              );
            } else {
              return const Center(child: Text('No payments found.'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showPaymentOptions(context),
          backgroundColor: const Color(0xFFF38B72),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.add, color: Color.fromARGB(255, 253, 220, 220)),
        ),
      ),
    );
  }

  void _showPaymentOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return PaymentOptionsModal(
          onUploadTap: () {
            context.pop();
            showAppDialog(
              context,
              AppDialogModel(
                title: 'Add new payment',
                child: PaymentAddDialog(),
              ),
            );
          },
          onPayPalTap: () {
            _showPayPalScreen(context);
          },
        );
      },
    );
  }

  // void _showUploadModal(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           String? fileName;

  //           return AlertDialog(
  //             title: const Text('Upload Slip'),
  //             content: SizedBox(
  //               width: double.maxFinite,
  //               child: BlocProvider(
  //                 create: (context) => PaymentsCubit(
  //                   paymentsRepository: services.get<PaymentsRepository>(),
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text(
  //                         fileName ?? 'No file selected',
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 10),
  //                       GestureDetector(
  //                         onTap: () async {
  //                           final pickedFile = await ImagePicker().pickImage(
  //                             source: ImageSource.gallery,
  //                           );
  //                           if (pickedFile != null) {
  //                             setState(() {
  //                               fileName = pickedFile.path;
  //                             });
  //                           }
  //                         },
  //                         child: Text(
  //                           'Browse your slip',
  //                           style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 20,
  //                             decoration: TextDecoration.underline,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 20),
  //                       BlocConsumer<PaymentsCubit, PaymentsState>(
  //                         listener: (context, state) {},
  //                         builder: (context, state) {
  //                           return Column(
  //                             children: [
  //                               SizedBox(
  //                                 width: double.infinity,
  //                                 child: ElevatedButton(
  //                                   onPressed: () async {},
  //                                   style: ElevatedButton.styleFrom(
  //                                     backgroundColor: Color(0xFFF38B72),
  //                                     shape: RoundedRectangleBorder(
  //                                       side: BorderSide(
  //                                           color: Color(0xFFF38B72)),
  //                                       borderRadius: BorderRadius.zero,
  //                                     ),
  //                                   ),
  //                                   child: const Text(
  //                                     'Upload slip',
  //                                     style: TextStyle(color: Colors.white),
  //                                   ),
  //                                 ),
  //                               ),
  //                               const SizedBox(height: 10),
  //                               SizedBox(
  //                                 width: double.infinity,
  //                                 child: ElevatedButton(
  //                                   onPressed: () {
  //                                     Navigator.of(context).pop();
  //                                   },
  //                                   style: ElevatedButton.styleFrom(
  //                                     backgroundColor: Colors.white,
  //                                     side:
  //                                         BorderSide(color: Color(0xFFF38B72)),
  //                                     shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.zero,
  //                                     ),
  //                                   ),
  //                                   child: const Text(
  //                                     'Cancel',
  //                                     style: TextStyle(
  //                                         color:
  //                                             Color(0xFFF38B72)), // Boja teksta
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _showPayPalScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PayPalScreen(),
      ),
    );
  }
}
