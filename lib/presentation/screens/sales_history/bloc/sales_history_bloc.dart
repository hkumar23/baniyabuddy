import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:baniyabuddy/data/repositories/transaction_repo.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SalesHistoryBloc extends Bloc<SalesHistoryEvent, SalesHistoryState> {
  SalesHistoryBloc() : super(InitialSalesHistoryState()) {
    on<FetchSalesHistoryEvent>(_onfetchSalesHistoryEvent);
    on<FilterTransactionsListEvent>(_onFilterTransactionsListEvent);
  }
  void _onfetchSalesHistoryEvent(event, emit) async {
    final TransactionRepo transactionRepo = TransactionRepo();
    emit(SalesHistoryLoadingState());
    try {
      final transactionsList = await transactionRepo.getTransactionsList();
      transactionsList.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      emit(SalesHistoryFetchedDataState(transactionsList: transactionsList));
      return;
    } catch (err) {
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }

  void _onFilterTransactionsListEvent(event, emit) async {
    final TransactionRepo transactionRepo = TransactionRepo();
    // print("Filtering Transactions List");
    // emit(SalesHistoryLoadingState());
    try {
      final List<TransactionDetails> transactionsList =
          await transactionRepo.getTransactionsList();
      List<TransactionDetails> filteredList;
      if (event.filter == AppLanguage.all) {
        filteredList = transactionsList;
      } else {
        filteredList = transactionsList
            .where((element) => element.paymentMethod == event.filter)
            .toList();
      }
      filteredList.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      emit(TransactionsListFilteredState(
          transactionsList: filteredList, filter: event.filter));
    } catch (err) {
      debugPrint("Error: $err");
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }
}
