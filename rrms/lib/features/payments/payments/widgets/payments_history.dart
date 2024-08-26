import 'package:flutter/material.dart';
import 'package:rrms/domain/models/payment/response_models/payment_response_model.dart';

class TransactionCard extends StatelessWidget {
  final VoidCallback onTap;
  final PaymentResponseModel payment;

  const TransactionCard({
    Key? key,
    required this.onTap,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Row(
              children: [
                Image.asset('assets/flat.png', height: 20, width: 20),
                const SizedBox(width: 10),
                Text(
                  '${payment.residenceName}, ${payment.amount}\$',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildRow('assets/name.png', 'Tenant: ${payment.residentName}'),
                const SizedBox(height: 5),
                _buildRow('assets/date.png', 'Date: ${payment.paymentDate}'),
                const SizedBox(height: 5),
                _buildRow('assets/phone.png', 'Phone number: +4345459563'), // Replace with real data if available
                const SizedBox(height: 5),
                _buildRow('assets/dolar.png', '${payment.amount}\$'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String asset, String text) {
    return Row(
      children: [
        Image.asset(asset, height: 20, width: 20),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}
