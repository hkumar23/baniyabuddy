import 'package:baniyabuddy/data/models/transaction_details.dart';

abstract class SalesHistoryEvent {}

class FetchSalesHistoryEvent extends SalesHistoryEvent {}

class FilterTransactionsListEvent extends SalesHistoryEvent {
  final String filter;
  final String timePeriodFilter;
  FilterTransactionsListEvent({
    required this.filter,
    required this.timePeriodFilter,
  });
}

class TimePeriodFilterEvent extends SalesHistoryEvent {
  final String filter;
  final String timePeriodFilter;
  TimePeriodFilterEvent({
    required this.filter,
    required this.timePeriodFilter,
  });
}
