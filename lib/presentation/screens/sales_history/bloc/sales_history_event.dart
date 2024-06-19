abstract class SalesHistoryEvent {}

class FetchSalesHistoryEvent extends SalesHistoryEvent {}

class FilterTransactionsListEvent extends SalesHistoryEvent {
  final String filter;
  FilterTransactionsListEvent(this.filter);
}
