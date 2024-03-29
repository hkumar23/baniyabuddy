import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class AppMethods {
  static bool isOperator(String value) {
    return ['+', '-', '*', '/', '%', 'a', '=', 'd'].contains(value);
  }

  static String removeLastChar(String value) {
    if (value.length <= 1) return "";
    return value.substring(0, value.length - 1);
  }

  static String calculateResult(String infixExpression) {
    if (infixExpression.isEmpty) return "";
    try {
      // Create a parser
      Parser p = Parser();

      // Parse the expression
      Expression exp = p.parse(infixExpression);

      // Create a context
      ContextModel cm = ContextModel();

      // Evaluate the expression
      double result = exp.evaluate(EvaluationType.REAL, cm);

      return result.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Invalid Expression");
    }
  }
}
