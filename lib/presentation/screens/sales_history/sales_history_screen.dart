import 'package:flutter/material.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Sales History',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ));
  }
}
