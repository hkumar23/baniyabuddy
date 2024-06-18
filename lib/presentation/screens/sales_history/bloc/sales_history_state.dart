import 'package:baniyabuddy/data/models/sales_record_details.dart';

abstract class SalesHistoryState {}

class InitialSalesHistoryState extends SalesHistoryState {}

class SalesHistoryLoadingState extends SalesHistoryState {}

class SalesHistoryErrorState extends SalesHistoryState {
  final String errorMessage;
  SalesHistoryErrorState({required this.errorMessage});
}

class SalesHistoryFetchedDataState extends SalesHistoryState {
  final List<SalesRecordDetails> listOfSalesRecordDetails;
  SalesHistoryFetchedDataState({required this.listOfSalesRecordDetails});
}
