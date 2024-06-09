import 'package:baniyabuddy/data/models/sales_record_details.dart';

abstract class CalculatorEvent {}

class NumberPressedEvent extends CalculatorEvent {
  final int number;

  NumberPressedEvent({required this.number});
}

class OperatorPressedEvent extends CalculatorEvent {
  final String operator;

  OperatorPressedEvent({required this.operator});
}

class RecordSalesEvent extends CalculatorEvent {
  final SalesRecordDetails salesRecordDetails;
  RecordSalesEvent({required this.salesRecordDetails});
}
