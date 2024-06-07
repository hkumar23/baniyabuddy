import 'dart:async';

import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendOTP extends StatefulWidget {
  const ResendOTP({required this.phoneNumber, super.key});
  final String phoneNumber;
  @override
  State<ResendOTP> createState() => _ResendOTPState();
}

int _start = 60;
bool isResendOtp = false;

class _ResendOTPState extends State<ResendOTP> {
  Timer? _timer;
  void resetResendOtp() {
    setState(() {
      _start = 0;
      isResendOtp = true;
    });
  }

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
    if (_start == 0) {
      resetResendOtp();
    }
    startTimer();
    return Column(
      // padding: const EdgeInsets.only(top: 8),
      children: [
        Wrap(
          // alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Didn't receive the OTP?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: isResendOtp
                  ? () {
                      BlocProvider.of<AuthBloc>(context).add(
                        SendCodeEvent(phoneNumber: widget.phoneNumber),
                      );
                      setState(() {
                        _start = 60;
                        isResendOtp = false;
                      });
                    }
                  : null,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
              ),
              child: Text(
                "RESEND OTP",
                style: TextStyle(
                  color: isResendOtp == true
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
        Text.rich(
          TextSpan(
            text: "in ",
            children: [
              TextSpan(
                text: "$_start",
                style: TextStyle(
                  color: _start > 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const TextSpan(
                text: " seconds",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
