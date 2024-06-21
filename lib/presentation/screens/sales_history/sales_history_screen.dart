import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => SalesHistoryBloc()..add(FetchSalesHistoryEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<SalesHistoryBloc, SalesHistoryState>(
          listener: (context, state) {
            if (state is SalesHistoryErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          },
          builder: (context, state) {
            List<TransactionDetails>? transactionsList;
            if (state is SalesHistoryFetchedDataState) {
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
                  flex: 2,
                  child: TotalSalesWidget(deviceSize: deviceSize),
                ),
                Expanded(
                  flex: 7,
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
                                  child: Column(
                                    children: [
                                      for (int i = 0;
                                          i < transactionsList.length;
                                          i++)
                                        SalesHistoryItem(
                                          deviceSize: deviceSize,
                                          transactionDetails:
                                              transactionsList[i],
                                        ),
                                    ],
                                  ),
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
    );
  }
}
