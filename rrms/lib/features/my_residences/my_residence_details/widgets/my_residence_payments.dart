import 'package:rrms/_all.dart';

class MyResidencePayments extends StatelessWidget {
  final int residenceId;

  const MyResidencePayments({
    super.key,
    required this.residenceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<PaymentsCubit>()..load(PaymentSearchRequestModel(residenceId: residenceId)),
      child: BlocBuilder<PaymentsCubit, PaymentsState>(
        builder: (context, paymentsState) {
          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: paymentsState.payments.count,
            itemBuilder: (context, index) {
              final payment = paymentsState.payments[index];

              return ResidencePaymentsListTile(payment: payment);
            },
            separatorBuilder: (context, index) => const Gap(15),
          );
        },
      ),
    );
  }
}
