abstract class SalesHistoryEvent {}

class FetchSalesHistoryEvent extends SalesHistoryEvent {}

class FetchTransactionsFromFirebaseEvent extends SalesHistoryEvent {}

class TimePeriodFilterEvent extends SalesHistoryEvent {
  final String timePeriodFilter;
  final String filter;
  final String searchedString;
  TimePeriodFilterEvent({
    required this.timePeriodFilter,
    required this.filter,
    required this.searchedString,
  });
}

class FilterTransactionsListEvent extends SalesHistoryEvent {
  final String timePeriodFilter;
  final String filter;
  final String searchedString;
  FilterTransactionsListEvent({
    required this.timePeriodFilter,
    required this.filter,
    required this.searchedString,
  });
}

class SearchTransactionsListEvent extends SalesHistoryEvent {
  final String timePeriodFilter;
  final String filter;
  final String searchedString;
  SearchTransactionsListEvent({
    required this.timePeriodFilter,
    required this.filter,
    required this.searchedString,
  });
}

class DeleteTransactionEvent extends SalesHistoryEvent {
  final String docId;
  DeleteTransactionEvent({required this.docId});
}
