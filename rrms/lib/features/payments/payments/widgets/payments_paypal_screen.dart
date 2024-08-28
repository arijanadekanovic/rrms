import 'package:rrms/features/payments/payments/cubits/payments_cubit.dart';
import 'package:rrms/features/payments/payments/cubits/payments_state.dart';
import 'package:rrms/_all.dart';

class PayPalScreen extends StatelessWidget {
  const PayPalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay your rent'),
      ),
      body: BlocProvider(
        create: (context) => PaymentsCubit(
          paymentsRepository: services.get<
              PaymentsRepository>(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Securely pay your monthly rent using your PayPal account',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset('assets/paypal.png', height: 50),
                    const SizedBox(height: 20),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        hintText: 'Enter rent amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<PaymentsCubit, PaymentsState>(
                      listener: (context, state) {
                        if (state.status == PaymentsStateStatus.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Payment successful!')),
                          );
                          Navigator.of(context).pop();
                        } else if (state.status ==
                            PaymentsStateStatus.failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Payment failed: ${state.errorMessage}')),
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final double? amount =
                                  double.tryParse(amountController.text);
                              if (amount != null) {
                                context
                                    .read<PaymentsCubit>()
                                    .processPayment(amount);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please enter a valid amount.')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child:
                                state.status == PaymentsStateStatus.processing
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text(
                                        'Pay Now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 100,
                  child: Button(
                    text: 'Cancel',
                    onTap: () => Navigator.of(context).pop(),
                    secondary: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
