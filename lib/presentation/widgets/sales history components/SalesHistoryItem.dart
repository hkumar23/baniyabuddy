import 'package:flutter/material.dart';

class SalesHistoryItem extends StatelessWidget {
  const SalesHistoryItem({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //IMPLEMENT THIS
      height: 120,
      width: deviceSize.width,
      // color: Colors.amber,
    );
  }
}
