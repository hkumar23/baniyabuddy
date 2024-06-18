import 'package:baniyabuddy/data/models/sales_record_details.dart';
import 'package:baniyabuddy/data/repositories/sales_record_repo.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/sales history components/sales_history_item.dart';
import '../../widgets/sales history components/filters_row.dart';
import '../../widgets/sales history components/total_sales_widget.dart';
import 'bloc/sales_history_state.dart';

class SalesHistory extends StatefulWidget {
  const SalesHistory({super.key});

  @override
  State<SalesHistory> createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {
  late SalesHistoryBloc _salesHistoryBloc;
  @override
  void initState() {
    super.initState();
    _salesHistoryBloc =
        SalesHistoryBloc(salesHistoryRepository: SalesRecordRepo());
    _salesHistoryBloc.add(FetchSalesHistoryEvent());
  }

  @override
  void dispose() {
    _salesHistoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    List<SalesRecordDetails>? listOfSalesRecordDetails;
    // double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return BlocProvider(
      create: (context) => _salesHistoryBloc,
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
              } else if (state is SalesHistoryFetchedDataState) {
                listOfSalesRecordDetails = state.listOfSalesRecordDetails;
              }
            },
            builder: (context, state) {
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
                          Container(
                            // color: Colors.amber,
                            padding: const EdgeInsets.only(
                                top: 5, left: 4, bottom: 5),
                            child: Row(
                              children: [
                                // Text(
                                //   AppLanguage.salesHistory,
                                //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                // ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText:
                                              "Search with Name / Phone Number",
                                          filled: true,
                                          fillColor: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.1),
                                          border: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide.none,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.search),
                                            padding: const EdgeInsets.all(0),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: listOfSalesRecordDetails == null
                                  ? const Center(
                                      child: Text(
                                          "You have not made any sales yet!"),
                                    )
                                  : Column(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                listOfSalesRecordDetails!
                                                    .length;
                                            i++)
                                          SalesHistoryItem(
                                            deviceSize: deviceSize,
                                            saleDetails:
                                                listOfSalesRecordDetails![i],
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
          )),
    );
  }
}
