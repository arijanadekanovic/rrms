import 'package:flutter/material.dart';
import '../../../../app/widgets/button.dart';

class UploadModal extends StatelessWidget {
  const UploadModal({Key? key, required Null Function() onUploadTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_upload, size: 70, color: Color(0xFFF38B72)),
          const SizedBox(height: 20),
          const Text(
            'Browse .pdf, .jpeg or .png file to upload payment slip',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 270,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Implement the upload functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF38B72),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Upload File', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: SizedBox(
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
}
