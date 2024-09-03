import 'package:rrms/_all.dart';

class ResidencePaymentsListTile extends StatelessWidget {
  const ResidencePaymentsListTile({
    super.key,
    required this.payment,
  });

  final PaymentResponseModel payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.appTheme.cardBackgroundColor,
        border: Border.all(color: context.appTheme.separator),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                payment.residentName.value + ',',
                style: context.textStyle.t16700.withColor(context.appTheme.primaryColor),
              ),
              const Gap(10),
              Text(
                style: context.textStyle.t16700.withColor(context.appTheme.primaryColor),
                payment.amount.formatPriceWithCurrency(),
              ),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: Text(
                  style: context.textStyle.t14500,
                  'Payment date: ' + payment.paymentDate.formatDateTime(),
                ),
              ),
              Icon(
                Icons.check,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
