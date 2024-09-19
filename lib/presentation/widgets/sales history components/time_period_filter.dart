import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimePeriodFilter extends StatefulWidget {
  const TimePeriodFilter({super.key});

  @override
  State<TimePeriodFilter> createState() => _TimePeriodFilterState();
}

class _TimePeriodFilterState extends State<TimePeriodFilter> {
  List<String> dropdownOptions = [
    "Today",
    "Yesterday",
    "1 Week",
    "2 Weeks",
    "3 Weeks",
    "1 Month",
    "3 Months",
    "6 Months",
  ];
  String selectedOption = AppLanguage.sixMonths;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesHistoryBloc, SalesHistoryState>(
      builder: (context, state) {
        if (state is TransactionsListFilteredState) {
          selectedOption = state.timePeriodFilter;
        }
        return Container(
          // height: 100,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton(
            value: selectedOption,
            onChanged: (value) {
              context.read<SalesHistoryBloc>().add(TimePeriodFilterEvent(
                    timePeriodFilter: value!,
                    filter: AppLanguage.all,
                    searchedString: "",
                  ));

              setState(() {
                selectedOption = value;
              });
            },
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            underline: Container(
              color: Colors.transparent,
            ),
            isDense: true,
            items: dropdownOptions.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
