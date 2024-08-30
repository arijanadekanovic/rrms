import 'package:flutter/material.dart';
import '../../../../app/widgets/button.dart';

class PaymentOptionsModal extends StatelessWidget {
  final VoidCallback onUploadTap;
  final VoidCallback onPayPalTap;

  const PaymentOptionsModal({
    Key? key,
    required this.onUploadTap,
    required this.onPayPalTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please select an option:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'If you would like to upload a payment slip choose the following option:',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 30),
          _buildDialogButton(
            context,
            'Upload file',
            Color(0xFFF38B72),
            onUploadTap,
          ),
          const SizedBox(height: 30),
          const Text(
            'If you would like to pay the next rent use our PayPal payment option:',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 30),
          _buildDialogButton(
            context,
            'Pay with PayPal',
            Colors.blue,
            onPayPalTap,
          ),
        ],
      ),
      actions: [
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
    );
  }

  Widget _buildDialogButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
