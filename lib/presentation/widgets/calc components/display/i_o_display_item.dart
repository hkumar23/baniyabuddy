import 'package:flutter/material.dart';

class IODisplayItem extends StatelessWidget {
  const IODisplayItem({
    super.key,
    required this.flex,
    required this.backgroundColor,
    // required this.alignment,
    required this.scrollController,
    required this.expression,
    // required this.mainAxisAlignment,
    required this.fontSize,
    required this.isUpperDisplay,
  });
  final int flex;
  final Color backgroundColor;
  // final AlignmentGeometry alignment;
  final ScrollController? scrollController;
  final String expression;
  // final MainAxisAlignment mainAxisAlignment;
  final double fontSize;
  final bool isUpperDisplay;

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    // print("ExpressionLength: ${expression.length}");
    // print("DeviceWidth: ${deviceSize.width}");
    return Expanded(
      flex: flex,
      child: Container(
        color: backgroundColor,
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(5),
        // alignment: alignment,
        child: isUpperDisplay
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 5),
                  child: Text(
                    // overflow: TextOverflow.visible,
                    expression,
                    style: TextStyle(fontSize: fontSize),
                    // softWrap: true,
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                child: Row(
                  // mainAxisAlignment:
                  //     MainAxisAlignment.spaceEvenly, // Align text to the right
                  children: [
                    Text(
                      expression,
                      style: TextStyle(fontSize: fontSize),
                    ),
                    if (expression.length >= 20) const SizedBox(width: 21)
                  ],
                ),
              ),
      ),
    );
  }
}
