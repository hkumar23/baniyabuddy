import '../../../../data/models/transaction.model.dart';

abstract class SalesHistoryState {}

class InitialSalesHistoryState extends SalesHistoryState {}

class SalesHistoryLoadingState extends SalesHistoryState {}

// class OnlyTransactionsLoadingState extends SalesHistoryState {}

class SalesHistoryErrorState extends SalesHistoryState {
  final String errorMessage;
  SalesHistoryErrorState({required this.errorMessage});
}

class SalesHistoryFetchedDataState extends SalesHistoryState {
  final List<TransactionDetails> transactionsList;
  final String totalSales;
  // final String timePeriodFilter;
  SalesHistoryFetchedDataState({
    required this.transactionsList,
    required this.totalSales,
  });
}

class TransactionsListFilteredState extends SalesHistoryState {
  final List<TransactionDetails> transactionsList;
  final String totalSales;
  final String timePeriodFilter;
  final String filter;
  final String searchedString;
  TransactionsListFilteredState({
    required this.transactionsList,
    required this.totalSales,
    required this.timePeriodFilter,
    required this.filter,
    required this.searchedString,
  });
}

class TransactionsDeletedState extends SalesHistoryState {}

class TransactionDeletionLoadingState extends SalesHistoryState {}
