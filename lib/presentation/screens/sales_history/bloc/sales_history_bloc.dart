import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:baniyabuddy/data/repositories/transaction_repo.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SalesHistoryBloc extends Bloc<SalesHistoryEvent, SalesHistoryState> {
  List<TransactionDetails> globalTransactionsList = [];
  List<TransactionDetails> mutableTransactionsList = [];

  SalesHistoryBloc() : super(InitialSalesHistoryState()) {
    on<FetchSalesHistoryEvent>(_onfetchSalesHistoryEvent);
    on<FilterTransactionsListEvent>(_onFilterTransactionsListEvent);
    on<TimePeriodFilterEvent>(_onTimePeriodFilterEvent);
  }

  void _onfetchSalesHistoryEvent(event, emit) async {
    final TransactionRepo transactionRepo = TransactionRepo();
    DateTime now = DateTime.now();
    emit(SalesHistoryLoadingState());

    try {
      globalTransactionsList = await transactionRepo.getTransactionsList();
      // for (int i = 0; i < transactionsList.length; i++) {
      //   await transactionRepo.addTransaction(transactionsList[i]);
      // }
      globalTransactionsList.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      DateTime sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
      mutableTransactionsList = globalTransactionsList
          .where((element) => element.timeStamp.isAfter(sixMonthsAgo))
          .toList();
      emit(SalesHistoryFetchedDataState(
          transactionsList: mutableTransactionsList));
      return;
    } catch (err) {
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }

  void _onTimePeriodFilterEvent(event, emit) {
    // Filter by time period
    DateTime now = DateTime.now();
    try {
      switch (event.timePeriodFilter) {
        case AppLanguage.today:
          mutableTransactionsList = globalTransactionsList
              .where((element) =>
                  element.timeStamp.year == now.year &&
                  element.timeStamp.month == now.month &&
                  element.timeStamp.day == now.day)
              .toList();
          break;
        case AppLanguage.yesterday:
          DateTime yesterday = now.subtract(const Duration(days: 1));
          mutableTransactionsList = globalTransactionsList
              .where((element) =>
                  element.timeStamp.year == yesterday.year &&
                  element.timeStamp.month == yesterday.month &&
                  element.timeStamp.day == yesterday.day)
              .toList();
          break;
        case AppLanguage.oneWeek:
          DateTime weekAgo = now.subtract(const Duration(days: 7));
          mutableTransactionsList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(weekAgo))
              .toList();
          break;
        case AppLanguage.twoWeeks:
          DateTime twoWeeksAgo = now.subtract(const Duration(days: 14));
          mutableTransactionsList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(twoWeeksAgo))
              .toList();
          break;
        case AppLanguage.threeWeeks:
          DateTime threeWeeksAgo = now.subtract(const Duration(days: 21));
          mutableTransactionsList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(threeWeeksAgo))
              .toList();
          break;
        case AppLanguage.oneMonth:
          DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
          mutableTransactionsList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(oneMonthAgo))
              .toList();
          break;
        case AppLanguage.threeMonths:
          DateTime threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
          mutableTransactionsList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(threeMonthsAgo))
              .toList();
          break;
        case AppLanguage.sixMonths:
          DateTime sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
          mutableTransactionsList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(sixMonthsAgo))
              .toList();
          break;
        // case AppLanguage.allTime:
        //   // No filtering by time period
        //   break;
      }
      emit(TransactionsListFilteredState(
        transactionsList: mutableTransactionsList,
        filter: AppLanguage.all,
        timePeriodFilter: event.timePeriodFilter,
      ));
    } catch (err) {
      debugPrint("Error: $err");
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }

  void _onFilterTransactionsListEvent(event, emit) async {
    // print("Filtering Transactions List");
    // emit(SalesHistoryLoadingState());
    try {
      List<TransactionDetails> filteredList = mutableTransactionsList;

      //Filter by payment method
      if (event.filter != AppLanguage.all) {
        filteredList = filteredList
            .where((element) => element.paymentMethod == event.filter)
            .toList();
      }

      // filteredList.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      emit(TransactionsListFilteredState(
        transactionsList: filteredList,
        filter: event.filter,
        timePeriodFilter: event.timePeriodFilter,
      ));
    } catch (err) {
      debugPrint("Error: $err");
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }
}
