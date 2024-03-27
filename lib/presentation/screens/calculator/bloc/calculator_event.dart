abstract class CalculatorEvent {}

class NumberPressedEvent extends CalculatorEvent {
  final int number;

  NumberPressedEvent({required this.number});
}

class OperatorPressedEvent extends CalculatorEvent {
  final String operator;

  OperatorPressedEvent({required this.operator});
}
// class AdditionEvent extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   AdditionEvent({required this.num1, required this.num2});
// }
// class SubtractionEvent extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   SubtractionEvent({required this.num1, required this.num2});
// }
// class MultiplicationEvent extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   MultiplicationEvent({required this.num1, required this.num2});
// }
// class DivisionEvent extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   DivisionEvent({required this.num1, required this.num2});
// }
// class ModuloEvent extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   ModuloEvent({required this.num1, required this.num2});
// }
// class AllClearEvent extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   AllClearEvent({required this.num1, required this.num2});
// }
// class EqualtoEvent extends CalculatorEvent {
//   final int num1;
//   final int num2;

//  EqualtoEvent({required this.num1, required this.num2});
// }
