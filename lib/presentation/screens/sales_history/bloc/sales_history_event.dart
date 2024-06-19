import 'package:baniyabuddy/data/models/transaction_details.dart';

abstract class SalesHistoryEvent {}

class FetchSalesHistoryEvent extends SalesHistoryEvent {}

class FilterTransactionsListEvent extends SalesHistoryEvent {
  final String? filter;
  final List<TransactionDetails>? transactionsList;
  FilterTransactionsListEvent({this.filter, this.transactionsList});
}
