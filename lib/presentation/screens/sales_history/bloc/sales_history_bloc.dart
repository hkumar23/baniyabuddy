import 'package:baniyabuddy/data/repositories/sales_record_repo.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:bloc/bloc.dart';

class SalesHistoryBloc extends Bloc<SalesHistoryEvent, SalesHistoryState> {
  SalesHistoryBloc() : super(InitialSalesHistoryState()) {
    on<FetchSalesHistoryEvent>(_onfetchSalesHistoryEvent);
  }
  void _onfetchSalesHistoryEvent(event, emit) async {
    final SalesRecordRepo salesHistoryRepo = SalesRecordRepo();

    emit(SalesHistoryLoadingState());
    try {
      final listOfSalesRecordDetails = await salesHistoryRepo.getSalesRecord();
      emit(SalesHistoryFetchedDataState(
          listOfSalesRecordDetails: listOfSalesRecordDetails));
      return;
    } catch (err) {
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }
}
