import 'package:baniyabuddy/data/models/transaction_details.dart';

abstract class SalesHistoryState {}

class InitialSalesHistoryState extends SalesHistoryState {}

class SalesHistoryLoadingState extends SalesHistoryState {}

class SalesHistoryErrorState extends SalesHistoryState {
  final String errorMessage;
  SalesHistoryErrorState({required this.errorMessage});
}

class SalesHistoryFetchedDataState extends SalesHistoryState {
  final List<TransactionDetails> transactionsList;
  SalesHistoryFetchedDataState({required this.transactionsList});
}

class TransactionsListFilteredState extends SalesHistoryState {
  final List<TransactionDetails> transactionsList;
  TransactionsListFilteredState({required this.transactionsList});
}
