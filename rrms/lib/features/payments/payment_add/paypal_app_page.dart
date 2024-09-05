import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:rrms/_all.dart';

class PaypalAppPage extends StatelessWidget {
  static const route = '/pay-with-paypal';

  const PaypalAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: RRMSAppBar(
        title: 'Pay your rent',
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          final amount = profileState.accountDetails?.residentInfo?.residencePrice ?? 0;
          final residentId = profileState.accountDetails?.residentInfo?.residentId ?? 0;

          return BlocProvider(
            create: (context) => services.get<PaymentAddCubit>()
              ..init(
                PaymentAddRequestModel(
                  amount: amount,
                  residentId: residentId,
                  paymentMethod: PaymentMethod.paypal,
                ),
              ),
            child: BlocConsumer<PaymentAddCubit, PaymentAddState>(
              listener: (context, paymentAddState) {
                if (paymentAddState.status == PaymentAddStateStatus.submittingSuccess) {
                  toast.success('Successfully paid your rent with paypal');
                  context.pop();
                }
              },
              builder: (context, paymentAddState) {
                final now = DateTime.now();

                return _PayPalView(
                  title: 'Rent for ${now.month}/${now.year}',
                  price: amount,
                  onSuccess: (paymentId) => context.read<PaymentAddCubit>().submit(
                        paymentAddState.model.copyWith(
                          payPalPaymentId: paymentId,
                        ),
                      ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _PayPalView extends StatelessWidget {
  final String title;
  final double price;
  final void Function(String paymentId)? onSuccess;

  const _PayPalView({
    required this.title,
    required this.price,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return PaypalCheckoutView(
      sandboxMode: true,
      clientId: appSettings.payPalAppSettings.clientId,
      secretKey: appSettings.payPalAppSettings.secretKey,
      note: title,
      transactions: [
        {
          'amount': {
            'total': price.formatPrice(),
            'currency': 'USD',
            'details': {
              'subtotal': price.formatPrice(),
              'shipping': '0',
              'shipping_discount': 0,
            }
          },
          'description': title,
          'item_list': {
            'items': [
              {'name': title, 'quantity': 1, 'price': price.formatPrice(), 'currency': 'USD'},
            ],
          }
        }
      ],
      onSuccess: (Map params) {
        final paymentId = params['data']?['id'];

        if (paymentId != null) {
          onSuccess?.call(paymentId);
        }
      },
      onError: (error) {
        toast.error(translations.there_was_an_error);
        print(error);
      },
      onCancel: () => context.pop(),
    );
  }
}
