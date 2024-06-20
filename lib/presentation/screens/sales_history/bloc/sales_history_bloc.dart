import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:baniyabuddy/data/repositories/transaction_repo.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SalesHistoryBloc extends Bloc<SalesHistoryEvent, SalesHistoryState> {
  List<TransactionDetails> globalTransactionsList = [];

  SalesHistoryBloc() : super(InitialSalesHistoryState()) {
    on<FetchSalesHistoryEvent>(_onfetchSalesHistoryEvent);
    on<FilterTransactionsListEvent>(_onFilterTransactionsListEvent);
  }
  void _onfetchSalesHistoryEvent(event, emit) async {
    final TransactionRepo transactionRepo = TransactionRepo();
    emit(SalesHistoryLoadingState());
    try {
      final transactionsList = await transactionRepo.getTransactionsList();
      // for (int i = 0; i < transactionsList.length; i++) {
      //   await transactionRepo.addTransaction(transactionsList[i]);
      // }
      transactionsList.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      globalTransactionsList = transactionsList;
      emit(SalesHistoryFetchedDataState(transactionsList: transactionsList));
      return;
    } catch (err) {
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }

  void _onFilterTransactionsListEvent(event, emit) async {
    // print("Filtering Transactions List");
    // emit(SalesHistoryLoadingState());
    try {
      List<TransactionDetails> filteredList = globalTransactionsList;
      if (event.filter != AppLanguage.all) {
        filteredList = filteredList
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
