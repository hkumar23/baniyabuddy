import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/sales_history_screen.dart';
import 'package:baniyabuddy/presentation/widgets/sales%20history%20components/time_period_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalSalesWidget extends StatelessWidget {
  const TotalSalesWidget({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesHistoryBloc, SalesHistoryState>(
      builder: (context, state) {
        String totalSales = "0";
        if (state is SalesHistoryFetchedDataState) {
          totalSales = state.totalSales;
        }
        if (state is TransactionsListFilteredState) {
          totalSales = state.totalSales;
        }
        return Container(
            padding: EdgeInsets.only(top: deviceSize.height * 0.05),
            width: deviceSize.width,
            color: Theme.of(context).colorScheme.inversePrimary,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLanguage.salesHistory,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          // Text(
                          //   "Welcome back!",
                          //   style: Theme.of(context).textTheme.titleMedium,
                          // ),
                        ],
                      ),
                      const Spacer(),
                      const TimePeriodFilter(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLanguage.totalSales,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 8),
                            Text(
                              "₹ $totalSales",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
