import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../constants/app_constants.dart';
import 'copyable_textfeild.dart';

class SupportDevButton extends StatelessWidget {
  const SupportDevButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Scan the QR code below with any UPI payments app',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    "assets/images/upi_apps_logo/payment-icons.png",
                    height: 40,
                  ),
                  const SizedBox(height: 5),
                  const CopyableTextField(text: AppConstants.supportDevUpi),
                  const SizedBox(height: 10),
                  SizedBox(
                    //gives error in android 13+ if sized box not used
                    height: 230,
                    width: 230,
                    child: QrImageView(
                      backgroundColor: Colors.white,
                      data:
                          "upi://pay?pa=${AppConstants.supportDevUpi}&pn=${"Codeworks Infinity"}&cu=INR",
                      version: QrVersions.auto,
                      size: 230,
                      gapless: false,
                      errorStateBuilder: (cxt, err) {
                        return const Center(
                          child: Text(
                            'Uh oh! Something went wrong...',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                  // // ),
                  const SizedBox(height: 20),
                  Text(
                    'Thank you for your support!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
                // ),
                // actions: <Widget>[
                //   TextButton(
                //     child: const Text('Close'),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue], // Gradient colors
              ),
              borderRadius: BorderRadius.circular(14), // Border radius
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.favorite),
                  SizedBox(width: 5),
                  Text("Support Development"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
