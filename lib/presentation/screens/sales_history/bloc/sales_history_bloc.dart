import 'package:baniyabuddy/data/repositories/transaction_repo.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:bloc/bloc.dart';

class SalesHistoryBloc extends Bloc<SalesHistoryEvent, SalesHistoryState> {
  SalesHistoryBloc() : super(InitialSalesHistoryState()) {
    on<FetchSalesHistoryEvent>(_onfetchSalesHistoryEvent);
  }
  void _onfetchSalesHistoryEvent(event, emit) async {
    final TransactionRepo transactionRepo = TransactionRepo();

    emit(SalesHistoryLoadingState());
    try {
      final transactionsList = await transactionRepo.getTransactionsList();
      emit(SalesHistoryFetchedDataState(transactionsList: transactionsList));
      return;
    } catch (err) {
      emit(SalesHistoryErrorState(errorMessage: err.toString()));
    }
  }
}
