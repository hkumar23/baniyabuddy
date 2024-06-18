import 'dart:math';

import 'package:baniyabuddy/data/repositories/sales_record_repo.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:bloc/bloc.dart';

class SalesHistoryBloc extends Bloc<SalesHistoryEvent, SalesHistoryState> {
  final SalesRecordRepo salesHistoryRepository;

  SalesHistoryBloc({required this.salesHistoryRepository})
      : super(InitialSalesHistoryState()) {
    on<FetchSalesHistoryEvent>(_onfetchSalesHistoryEvent);
  }
  void _onfetchSalesHistoryEvent(event, emit) async {
    emit(SalesHistoryLoadingState());
    try {
      final listOfSalesRecordDetails =
          await salesHistoryRepository.getSalesRecord();
      emit(SalesHistoryFetchedDataState(
          listOfSalesRecordDetails: listOfSalesRecordDetails));
      return;
    } catch (err) {
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }
}
