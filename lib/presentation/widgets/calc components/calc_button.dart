import 'package:baniyabuddy/constants/app_language.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalcButton extends StatelessWidget {
  const CalcButton({
    super.key,
    required this.subject,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
  });
  final subject;
  final Color buttonColor;
  final Color textColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // flex: 1,
      // padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(2),
        constraints: const BoxConstraints.expand(),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: buttonColor,
          ),
          child: FittedBox(
            child: subject is IconData
                ? Icon(
                    subject,
                    size: 40,
                    color: textColor,
                  )
                : Text(
                    subject,
                    style:
                        // GoogleFonts.robotoMono(
                        //   fontSize: 40,
                        //   color: textColor,
                        //   // fontWeight: FontWeight.bold,
                        // ),
                        TextStyle(
                      fontSize: 40,
                      color: textColor,
                      fontWeight: subject == AppLanguage.ac
                          ? FontWeight.w400
                          : FontWeight.w300,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
