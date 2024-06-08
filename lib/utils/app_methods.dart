import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  static bool isNumeric(String s) {
    return RegExp(r'^[0-9]+$').hasMatch(s);
  }

  static void logoutWithDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Theme.of(context).colorScheme.shadow,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text("Are you sure you want to logout?"),
          actions: [
            OutlinedButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              child: const Text(AppLanguage.yes),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppLanguage.no),
            )
          ],
        );
      },
    );
  }
}
