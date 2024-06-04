import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OTPTimer extends StatefulWidget {
  const OTPTimer({super.key});

  @override
  State<OTPTimer> createState() => _OTPTimerState();
}

int _start = 60;

class _OTPTimerState extends State<OTPTimer> {
  Timer? _timer;

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    // _start = 60; // Reset timer value

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text.rich(TextSpan(text: "in ", children: [
        TextSpan(
          text: "$_start",
          style: TextStyle(
            color: _start == 0 ? Colors.teal : Colors.red,
          ),
        ),
        const TextSpan(
          text: " seconds",
        ),
      ])),
    );
  }
}
