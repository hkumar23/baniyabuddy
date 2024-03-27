import 'package:baniyabuddy/presentation/widgets/calc%20components/calc_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    super.key,
    required this.buttonColor1,
    required this.buttonColor2,
    required this.buttonColor3,
    required this.buttonColor4,
    required this.subject1,
    required this.subject2,
    required this.subject3,
    required this.subject4,
    required this.textColor1,
    required this.textColor2,
    required this.textColor3,
    required this.textColor4,
  });
  final Color buttonColor1;
  final Color buttonColor2;
  final Color buttonColor3;
  final Color buttonColor4;

  final subject1;
  final subject2;
  final subject3;
  final subject4;

  final Color textColor1;
  final Color textColor2;
  final Color textColor3;
  final Color textColor4;
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: Row(
        children: [
          // CalcButton(
          //   buttonColor: buttonColor1,
          //   subject: subject1,
          //   textColor: textColor1,
          // ),
          // CalcButton(
          //   buttonColor: buttonColor2,
          //   subject: subject2,
          //   textColor: textColor2,
          // ),
          // CalcButton(
          //   buttonColor: buttonColor3,
          //   subject: subject3,
          //   textColor: textColor3,
          // ),
          // CalcButton(
          //     buttonColor: buttonColor4,
          //     subject: subject4,
          //     textColor: textColor4),
        ],
      ),
    );
  }
}
