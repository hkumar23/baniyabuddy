import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCode extends StatelessWidget {
  GenerateQrCode({
    super.key,
    required this.upiId,
    required this.businessName,
    required this.amount,
  });
  String amount;
  String businessName;
  String upiId;
  @override
  Widget build(BuildContext context) {
    // Define your UPI URL

    String upiUrl = "upi://pay?pa=$upiId&pn=$businessName&am=$amount&cu=INR";

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Container(
        color: Colors.white,
        width: 280,
        height: 280,
        padding: const EdgeInsets.all(10),
        child: QrImageView(
          // embeddedImage: const AssetImage("assets/logo/baniya_buddy_logo.png"),
          backgroundColor: Colors.white,
          data: upiUrl,
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
    );
  }
}
