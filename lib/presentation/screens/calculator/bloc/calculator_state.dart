import 'package:flutter/material.dart';

class CalculatorState {
  String inputExpression;
  String output;
  ScrollController scrollController = ScrollController();
  CalculatorState({
    required this.inputExpression,
    required this.output,
  });
}
