import 'package:baniyabuddy/data/models/transaction.model.dart';

abstract class CalculatorEvent {}

class NumberPressedEvent extends CalculatorEvent {
  final int number;

  NumberPressedEvent({required this.number});
}

class OperatorPressedEvent extends CalculatorEvent {
  final String operator;

  OperatorPressedEvent({required this.operator});
}

class SaveTransactionEvent extends CalculatorEvent {
  final TransactionDetails transactionDetails;
  SaveTransactionEvent({required this.transactionDetails});
}
