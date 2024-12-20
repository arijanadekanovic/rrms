import 'package:rrms/_all.dart';
import 'package:rrms/features/payments/payments/widgets/payments_options_modal.dart';
import 'package:rrms/features/payments/payments/widgets/payments_slip_list.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<PaymentsCubit>()..load(),
      child: AppScaffold(
        appBar: RRMSAppBar(
          title: 'Payments',
          primary: true,
        ),
        body: BlocBuilder<PaymentsCubit, PaymentsState>(
          builder: (context, state) {
            if (state.status == PaymentsStateStatus.loading) {
              return const Loader();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.payments.length,
              itemBuilder: (context, index) {
                return PaymentSlipList(
                  payment: state.payments[index],
                );
              },
            );
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
            context.pop();
            context.push(PaypalAppPage.route);
          },
        );
      },
    );
  }
}
