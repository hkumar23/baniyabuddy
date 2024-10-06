import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCostumer extends StatefulWidget {
  const SearchCostumer({
    super.key,
  });

  @override
  State<SearchCostumer> createState() => _SearchCostumerState();
}

class _SearchCostumerState extends State<SearchCostumer> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Row(
    //   children: [
    //   Expanded(
    // child:
    return BlocBuilder<SalesHistoryBloc, SalesHistoryState>(
        builder: (context, state) {
      if (state is TransactionsListFilteredState) {
        searchController.text = state.searchedString;
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        // height: double.minPositive,
        child: TextField(
          controller: searchController,
          focusNode: searchFocusNode,
          onChanged: (value) {
            if (state is SalesHistoryFetchedDataState) {
              context.read<SalesHistoryBloc>().add(SearchTransactionsListEvent(
                    timePeriodFilter: AppLanguage.sixMonths,
                    filter: AppLanguage.all,
                    searchedString: searchController.text,
                  ));
            }
            if (state is TransactionsListFilteredState) {
              context.read<SalesHistoryBloc>().add(SearchTransactionsListEvent(
                    timePeriodFilter: state.timePeriodFilter,
                    filter: state.filter,
                    searchedString: searchController.text,
                  ));
            }
          },
          decoration: InputDecoration(
            hintText: "Search with Name / Phone Number",
            filled: true,
            fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search),
            // suffixIcon: IconButton(
            //   onPressed: () {
            // print(searchController.text);
            // if (state is SalesHistoryFetchedDataState) {
            //   context
            //       .read<SalesHistoryBloc>()
            //       .add(SearchTransactionsListEvent(
            //         timePeriodFilter: AppLanguage.sixMonths,
            //         filter: AppLanguage.all,
            //         searchedString: searchController.text,
            //       ));
            // }
            // if (state is TransactionsListFilteredState) {
            //   context
            //       .read<SalesHistoryBloc>()
            //       .add(SearchTransactionsListEvent(
            //         timePeriodFilter: state.timePeriodFilter,
            //         filter: state.filter,
            //         searchedString: searchController.text,
            //       ));
            // }
            //   },
            //   icon: const Icon(Icons.search),
            //   padding: const EdgeInsets.all(0),
            // ),
          ),
        ),
        // );
      );
      //   ),
      // ],
    });
  }
}
