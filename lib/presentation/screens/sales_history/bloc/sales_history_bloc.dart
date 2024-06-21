import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:baniyabuddy/data/repositories/transaction_repo.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SalesHistoryBloc extends Bloc<SalesHistoryEvent, SalesHistoryState> {
  List<TransactionDetails> globalTransactionsList = [];
  List<TransactionDetails> timePeriodFilteredList = [];
  List<TransactionDetails> filteredList = [];
  String totalSales = "0";

  SalesHistoryBloc() : super(InitialSalesHistoryState()) {
    on<FetchSalesHistoryEvent>(_onfetchSalesHistoryEvent);
    on<FilterTransactionsListEvent>(_onFilterTransactionsListEvent);
    on<TimePeriodFilterEvent>(_onTimePeriodFilterEvent);
    on<SearchTransactionsListEvent>(_onSearchTransactionsListEvent);
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
      timePeriodFilteredList = globalTransactionsList
          .where((element) => element.timeStamp.isAfter(sixMonthsAgo))
          .toList();
      filteredList = timePeriodFilteredList;
      totalSales = AppMethods.calcTransactionTotal(timePeriodFilteredList);
      emit(SalesHistoryFetchedDataState(
          transactionsList: timePeriodFilteredList, totalSales: totalSales));
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
          timePeriodFilteredList = globalTransactionsList
              .where((element) =>
                  element.timeStamp.year == now.year &&
                  element.timeStamp.month == now.month &&
                  element.timeStamp.day == now.day)
              .toList();
          break;
        case AppLanguage.yesterday:
          DateTime yesterday = now.subtract(const Duration(days: 1));
          timePeriodFilteredList = globalTransactionsList
              .where((element) =>
                  element.timeStamp.year == yesterday.year &&
                  element.timeStamp.month == yesterday.month &&
                  element.timeStamp.day == yesterday.day)
              .toList();
          break;
        case AppLanguage.oneWeek:
          DateTime weekAgo = now.subtract(const Duration(days: 7));
          timePeriodFilteredList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(weekAgo))
              .toList();
          break;
        case AppLanguage.twoWeeks:
          DateTime twoWeeksAgo = now.subtract(const Duration(days: 14));
          timePeriodFilteredList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(twoWeeksAgo))
              .toList();
          break;
        case AppLanguage.threeWeeks:
          DateTime threeWeeksAgo = now.subtract(const Duration(days: 21));
          timePeriodFilteredList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(threeWeeksAgo))
              .toList();
          break;
        case AppLanguage.oneMonth:
          DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
          timePeriodFilteredList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(oneMonthAgo))
              .toList();
          break;
        case AppLanguage.threeMonths:
          DateTime threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
          timePeriodFilteredList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(threeMonthsAgo))
              .toList();
          break;
        case AppLanguage.sixMonths:
          DateTime sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
          timePeriodFilteredList = globalTransactionsList
              .where((element) => element.timeStamp.isAfter(sixMonthsAgo))
              .toList();
          break;
        // case AppLanguage.allTime:
        //   // No filtering by time period
        //   break;
      }
      filteredList = timePeriodFilteredList;
      totalSales = AppMethods.calcTransactionTotal(timePeriodFilteredList);
      emit(TransactionsListFilteredState(
        transactionsList: timePeriodFilteredList,
        totalSales: totalSales,
        timePeriodFilter: event.timePeriodFilter,
        filter: AppLanguage.all,
        searchedString: "",
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
      //Filter by payment method
      if (event.filter == AppLanguage.all) {
        filteredList = timePeriodFilteredList;
      } else {
        filteredList = timePeriodFilteredList
            .where((element) => element.paymentMethod == event.filter)
            .toList();
      }
      totalSales = AppMethods.calcTransactionTotal(filteredList);
      emit(TransactionsListFilteredState(
        transactionsList: filteredList,
        totalSales: totalSales,
        timePeriodFilter: event.timePeriodFilter,
        filter: event.filter,
        searchedString: "",
      ));
    } catch (err) {
      debugPrint("Error: $err");
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }

  void _onSearchTransactionsListEvent(event, emit) {
    // print("Searching Transactions List ${event.searchedString}");
    List<TransactionDetails> searchedList = filteredList;
    try {
      if (event.searchedString.isNotEmpty) {
        searchedList = filteredList
            .where((element) =>
                element.costumerName
                    .toLowerCase()
                    .contains(event.searchedString.trim().toLowerCase()) ||
                element.mobNumber.contains(event.searchedString.trim()))
            .toList();
      }
      // print("Searched List: ${searchedList.length}");
      // print("Filtered list: ${filteredList.length}");
      emit(TransactionsListFilteredState(
        transactionsList: searchedList,
        totalSales: totalSales,
        timePeriodFilter: event.timePeriodFilter,
        filter: event.filter,
        searchedString: event.searchedString,
      ));
    } catch (err) {
      debugPrint("Error: $err");
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }
}
