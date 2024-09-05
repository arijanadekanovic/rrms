import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:rrms/_all.dart';

class PaymentHistory extends StatelessWidget {
  final PaymentResponseModel payment;

  const PaymentHistory({
    Key? key,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Row(
              children: [
                Image.asset('assets/flat.png', height: 20, width: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    payment.residenceName ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildRow('assets/name.png', 'Tenant: ${payment.residentName}'),
                const SizedBox(height: 5),
                _buildRow('assets/date.png', 'Date: ${payment.paymentDate.formatDateTime()}'),
                const SizedBox(height: 5),
                _buildRow('assets/dolar.png', '${payment.amount.formatPriceWithCurrency()}'),
                const SizedBox(height: 10),
                if (payment.slipUrl != null && payment.slipUrl!.isNotEmpty) _buildAttachmentRow(context),
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

  Widget _buildAttachmentRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.attach_file, size: 20),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            _handleAttachmentTap(context, payment.slipUrl!);
          },
          child: Text(
            'View Attachment',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAttachmentTap(BuildContext context, String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${url.split('/').last}');
      await file.writeAsBytes(bytes, flush: true);

      if (url.endsWith('.jpg') || url.endsWith('.png')) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageScreen(filePath: file.path),
          ),
        );
      } else if (url.endsWith('.pdf')) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFScreen(filePath: file.path),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unsupported file type')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load attachment')),
      );
    }
  }
}

class ImageScreen extends StatelessWidget {
  final String filePath;

  const ImageScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Image')),
      body: Center(
        child: Image.file(File(filePath)),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  final String filePath;

  const PDFScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View PDF')),
      body: PDFView(
        filePath: filePath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageFling: true,
      ),
    );
  }
}
