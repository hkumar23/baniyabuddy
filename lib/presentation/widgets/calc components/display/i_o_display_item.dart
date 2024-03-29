import 'package:flutter/material.dart';

class IODisplayItem extends StatelessWidget {
  const IODisplayItem({
    super.key,
    required this.flex,
    required this.backgroundColor,
    required this.alignment,
    required this.scrollController,
    required this.expression,
    required this.mainAxisAlignment,
    required this.fontSize,
  });
  final int flex;
  final Color backgroundColor;
  final AlignmentGeometry alignment;
  final ScrollController? scrollController;
  final String expression;
  final MainAxisAlignment mainAxisAlignment;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        color: backgroundColor,
        alignment: alignment,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              // const Text("Input Expression: "),
              Text(
                // softWrap: true,
                // textAlign: TextAlign.right,
                expression,
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
