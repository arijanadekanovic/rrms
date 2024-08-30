import 'package:rrms/_all.dart';
import 'package:rrms/features/payments/payments/cubits/payments_cubit.dart';
import 'package:rrms/features/payments/payments/cubits/payments_state.dart';
import 'package:rrms/features/payments/payments/widgets/payments_history.dart';
import 'package:rrms/features/payments/payments/widgets/payments_options_modal.dart';
import 'package:rrms/features/payments/payments/widgets/payments_paypal_screen.dart';
import 'package:rrms/features/payments/payments/widgets/payments_upload_modal.dart';

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
            Navigator.of(context).pop();
            _showUploadModal(context);
          },
          onPayPalTap: () {
            _showPayPalScreen(context);
          },
        );
      },
    );
  }

  void _showUploadModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return UploadModal(
          onUploadTap: () {
            Navigator.of(context).pop(); // Implement logic for upload
          },
        );
      },
    );
  }

  void _showPayPalScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PayPalScreen(),
      ),
    );
  }
}
