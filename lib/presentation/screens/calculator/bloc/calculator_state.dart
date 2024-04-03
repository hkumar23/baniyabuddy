import 'package:flutter/material.dart';

abstract class CalculatorState {
  String? inputExpression;
  String? output;
  ScrollController scrollController = ScrollController();
}

class InitialCalculatorState extends CalculatorState {
  InitialCalculatorState() {
    inputExpression = "";
    output = "";
  }
}

class EvaluateExpressionState extends CalculatorState {
  String inputExp;
  String outputExp;
  // ScrollController scrollController = ScrollController();
  EvaluateExpressionState({
    required this.inputExp,
    required this.outputExp,
  }) {
    inputExpression = inputExp;
    output = outputExp;
  }
}

class SaveTransactionState extends CalculatorState {}
