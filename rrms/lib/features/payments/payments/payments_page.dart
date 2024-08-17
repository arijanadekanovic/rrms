import 'package:rrms/_all.dart';

class PaymentsPage extends StatelessWidget {
  final String residenceName;

  const PaymentsPage({
    super.key,
    required this.residenceName,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: This widget should be payments history list (with a CTA button to initiate a new payment on new page, what is currently on this page)

    return AppScaffold(
      appBar: AppBar(
        title: Text('Pay your rent for: $residenceName'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Securely pay your monthly rent using your PayPal account',
                style: context.textStyle.t14500,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: context.appTheme.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/paypal.png', // Assuming you have this image in your assets
                      height: 50,
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      hint: 'Enter rent amount',
                      borderRadius: BorderRadius.circular(10),
                      height: 50, // Set height of AppTextField
                      // Adjust other properties as needed
                    ),
                    const SizedBox(height: 0), // Space between TextField and Button
                    SizedBox(
                      width: double.infinity, // Makes the button width same as AppTextField
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle payment logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Set button background color to blue
                          minimumSize: Size.fromHeight(50), // Make the button height same as TextField
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                            color: Colors.white, // Set button text color to white
                            fontSize: 16, // Adjust font size if necessary
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
