class AppMethods {
  static bool isOperator(String value) {
    return ['+', '-', '+', '/', '%', 'a', '=', 'd'].contains(value);
  }

  static String removeLastChar(String value) {
    return value.substring(0, value.length - 1);
  }

  static String calculateResult(int value1, int value2, String operator) {
    return '0';
  }
}
