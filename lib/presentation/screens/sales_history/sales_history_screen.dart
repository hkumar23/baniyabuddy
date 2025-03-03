import 'package:baniyabuddy/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/transaction.model.dart';
import '../sales_history/bloc/sales_history_bloc.dart';
import '../sales_history/bloc/sales_history_event.dart';
import '../../widgets/sales history components/sales_history_item.dart';
import '../../widgets/sales history components/filters_row.dart';
import '../../widgets/sales history components/search_costumer.dart';
import '../../widgets/sales history components/total_sales_widget.dart';
import 'bloc/sales_history_state.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  // late SalesHistoryBloc _salesHistoryBloc;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    // double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return
        // Scaffold(
        //   resizeToAvoidBottomInset: false,
        //   body:
        RefreshIndicator.adaptive(
      // backgroundColor: const Color.fromARGB(0, 155, 146, 146),
      onRefresh: () async {
        context.read<SalesHistoryBloc>().add(FetchSalesHistoryEvent());
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 155, 146, 146),
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<SalesHistoryBloc, SalesHistoryState>(
          listener: (context, state) {
            if (state is TransactionsDeletedState) {
              CustomSnackbar.neutral(
                context: context,
                text: "Transaction Deleted Successfully",
              );
            }
            if (state is SalesHistoryErrorState) {
              CustomSnackbar.error(
                context: context,
                text: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            List<TransactionDetails>? transactionsList;
            if (state is InitialSalesHistoryState) {
              context.read<SalesHistoryBloc>().add(FetchSalesHistoryEvent());
            }
            if (state is SalesHistoryFetchedDataState) {
              transactionsList = state.transactionsList;
            }
            if (state is TransactionsDeletedState) {
              transactionsList = state.transactionsList;
            }
            if (state is TransactionsListFilteredState) {
              // print(state.transactionsList.length);
              transactionsList = state.transactionsList;
            }
            if (state is SalesHistoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: TotalSalesWidget(deviceSize: deviceSize),
                ),
                Expanded(
                  flex: 13,
                  child: Container(
                    width: deviceSize.width,
                    // color: Colors.amber,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const FiltersRow(),
                        const SearchCostumer(),
                        transactionsList == null || transactionsList.isEmpty
                            ? const Center(
                                child: Text("You have not made any sales yet!"),
                              )
                            : Expanded(
                                child: SingleChildScrollView(
                                  // child: SizedBox(
                                  //   height:
                                  //       MediaQuery.of(context).size.height * 0.7,
                                  child: Column(
                                    children:
                                        _buildTransactionList(transactionsList),
                                  ),
                                  // ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      // ),
    );
  }
}

List<Widget> _buildTransactionList(
  List<TransactionDetails> transactionsList,
) {
  List<Widget> transactionWidgets = [];
  for (int i = 0; i < transactionsList.length; i++) {
    transactionWidgets.add(SalesHistoryItem(
      transactionDetails: transactionsList[i],
    ));
  }
  return transactionWidgets;
}
