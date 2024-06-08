import 'package:flutter/material.dart';

abstract class CalculatorState {
  String inputExpression = "";
  String output = "";
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
    // if (outputExp.isNotEmpty &&
    //     outputExp[outputExp.length - 2] == '.' &&
    //     outputExp[outputExp.length - 1] == '0') {
    //   output = outputExp.substring(0, outputExp.length - 2);
    // } else {
    //   output = outputExp;
    // }
    // inputExpression = inputExp;
    inputExpression = inputExp;
    output = outputExp;
  }
}

class SaveTransactionState extends CalculatorState {}

class CalcErrorState extends CalculatorState {
  final String errorMessage;
  CalcErrorState({required this.errorMessage});
}

class CalcLoadingState extends CalculatorState {}
