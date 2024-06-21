import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_item.dart';

class FiltersRow extends StatefulWidget {
  const FiltersRow({
    super.key,
    // required this.onTap,
  });
  // final void Function(String) onTap;
  @override
  State<FiltersRow> createState() => _FiltersRowState();
}

class _FiltersRowState extends State<FiltersRow> {
  String _selectedFilter = AppLanguage.all;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesHistoryBloc, SalesHistoryState>(
      builder: (context, state) {
        if (state is TransactionsListFilteredState) {
          _selectedFilter = state.filter;
        }
        void onTap(String filter) {
          // onTap(filter);
          if (state is SalesHistoryFetchedDataState) {
            context.read<SalesHistoryBloc>().add(FilterTransactionsListEvent(
                  timePeriodFilter: AppLanguage.sixMonths,
                  filter: filter,
                  searchedString: "",
                ));
          }
          if (state is TransactionsListFilteredState) {
            // print(filter);
            context.read<SalesHistoryBloc>().add(FilterTransactionsListEvent(
                  timePeriodFilter: state.timePeriodFilter,
                  filter: filter,
                  searchedString: "",
                ));
          }
          setState(() {
            _selectedFilter = filter;
          });
        }

        return Padding(
          padding: const EdgeInsets.only(top: 16, left: 2, right: 2),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterItem(
                  title: AppLanguage.all,
                  onTap: onTap,
                  isSelected: _selectedFilter == AppLanguage.all,
                ),
                FilterItem(
                  title: AppLanguage.upi,
                  onTap: onTap,
                  isSelected: _selectedFilter == AppLanguage.upi,
                ),
                FilterItem(
                  title: AppLanguage.cash,
                  onTap: onTap,
                  isSelected: _selectedFilter == AppLanguage.cash,
                ),
                FilterItem(
                  title: AppLanguage.udhaar,
                  onTap: onTap,
                  isSelected: _selectedFilter == AppLanguage.udhaar,
                ),
                FilterItem(
                    title: AppLanguage.netBanking,
                    onTap: onTap,
                    isSelected: _selectedFilter == AppLanguage.netBanking),
                FilterItem(
                  title: AppLanguage.creditDebitCard,
                  onTap: onTap,
                  isSelected: _selectedFilter == AppLanguage.creditDebitCard,
                ),
                FilterItem(
                  title: AppLanguage.others,
                  onTap: onTap,
                  isSelected: _selectedFilter == AppLanguage.notSelected,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
