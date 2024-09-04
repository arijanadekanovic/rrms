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
                  onSuccess: () {
                    print('SUCCESSFULLY PAID RENT');
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// class _PayPalView extends StatefulWidget {
//   final String title;
//   final double price;
//   final void Function()? onSuccess;

//   const _PayPalView({
//     required this.title,
//     required this.price,
//     this.onSuccess,
//   });

//   @override
//   State<_PayPalView> createState() => _PayPalViewState();
// }

// class _PayPalViewState extends State<_PayPalView> {
//   @override
//   void initState() {
//     super.initState();

//     PaypalCheckout()
//         .getMapCheckout(
//       clientId: appSettings.payPalAppSettings.clientId,
//       secretKey: appSettings.payPalAppSettings.secretKey,
//       note: widget.title,
//       transactions: [
//         {
//           'amount': {
//             'total': widget.price.toString(),
//             'currency': 'USD',
//             'details': {
//               'subtotal': widget.price.toString(),
//               'shipping': '0',
//               'shipping_discount': 0,
//             }
//           },
//           'description': widget.title,
//           'item_list': {
//             'items': [
//               {'name': widget.title, 'quantity': 1, 'price': widget.price.toString(), 'currency': 'USD'},
//             ],
//           }
//         }
//       ],
//       sandboxMode: true,
//       returnURL: 'http://localhost:60560/aprov?id=605656',
//       cancelURL: 'http://localhost:60560/cancelpag?id=05404',
//     )
//         .then(
//       (resultPaypal) {
//         print("url Aproval: ${resultPaypal['approvalUrl']}");
//         print("url execute: ${resultPaypal['executeUrl']}");

//         UrlLauncher(
//           resultPaypal['approvalUrl'],
//           LaunchMode.externalApplication,
//         ).launch();
//       },
//     );

//     // se site retorna par returnUrl que dizer pagamento  aprovafo
//     // var urlTest = Uri.parse("http://localhost:60560/aprov?id=605656&paymentId=PAYID-MZPVHII4SR58490MY497621F&token=EC-8D738479TE801835X&PayerID=ZQBVQPM2B6AVJ");

//     // mostrar paramentos  print("paramentros: ${urlTest.queryParameters}");
//     // mostrar paramentos Especifico print("paramentros: ${urlTest.queryParameters['id']}") resultado = 605656;
//     // example url pagamento aprovado http://localhost:60560/aprov?id=605656&paymentId=PAYID-MZPVHII4SR58490MY497621F&token=EC-8D738479TE801835X&PayerID=ZQBVQPM2B6AVJ;

//     /*  Paramentos para executar pagamento
//        String url = resultPaypal['executeUrl'];
//        String payerId = resultPaypal['PayerID'];
//        String accessToken = resultPaypal['token'];
//     */
//     //PaypalCheckout().executePayment(url, payerId, accessToken);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Loader();
//   }
// }

// import 'package:paypal_payment/paypal_payment.dart';
// class _PayPalView extends StatelessWidget {
//   final String title;
//   final double price;
//   final void Function()? onSuccess;

//   const _PayPalView({
//     required this.title,
//     required this.price,
//     this.onSuccess,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PaypalOrderPayment(
//       sandboxMode: true,
//       note: title,
//       returnURL: 'http://localhost:63329/app/example',
//       cancelURL: 'http://localhost:63329/app/example',
//       clientId: appSettings.payPalAppSettings.clientId,
//       secretKey: appSettings.payPalAppSettings.secretKey,
//       currencyCode: 'USD',
//       amount: price.toString(),
//       onSuccess: () => onSuccess?.call(),
//       onError: () => toast.error(translations.there_was_an_error),
//       onCancel: () => context.pop(),
//     );
//   }
// }

class _PayPalView extends StatelessWidget {
  final String title;
  final double price;
  final void Function()? onSuccess;

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
            'total': price.toString(),
            'currency': 'USD',
            'details': {
              'subtotal': price.toString(),
              'shipping': '0',
              'shipping_discount': 0,
            }
          },
          'description': title,
          'item_list': {
            'items': [
              {'name': title, 'quantity': 1, 'price': price.toString(), 'currency': 'USD'},
            ],
          }
        }
      ],
      onSuccess: (Map params) => onSuccess?.call(),
      onError: (error) {
        toast.error(translations.there_was_an_error);
        print(error);
      },
      onCancel: () => context.pop(),
    );
  }
}
