import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/custom_top_snackbar.dart';

class CopyableTextField extends StatelessWidget {
  final String text;
  const CopyableTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
        CustomTopSnackbar.success(context, "Text copied to clipboard!");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("UPI: "),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.copy,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
