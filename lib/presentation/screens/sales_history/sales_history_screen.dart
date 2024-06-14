import 'package:flutter/material.dart';

import '../../widgets/sales history components/sales_history_item.dart';
import '../../widgets/sales history components/filters_row.dart';
import '../../widgets/sales history components/total_sales_widget.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //   title: const Text(
        //     'Sales History',
        //     style: TextStyle(
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        //   centerTitle: true,
        // ),
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: TotalSalesWidget(deviceSize: deviceSize),
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: deviceSize.width,
            // color: Colors.amber,
            margin: const EdgeInsets.only(top: 16, left: 12, right: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const FiltersRow(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Text(
                          "Sales History",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        )
                      ],
                    ),
                  ),
                  SalesHistoryItem(deviceSize: deviceSize),
                  SalesHistoryItem(deviceSize: deviceSize),
                  SalesHistoryItem(deviceSize: deviceSize),
                  SalesHistoryItem(deviceSize: deviceSize),
                  SalesHistoryItem(deviceSize: deviceSize),
                  SalesHistoryItem(deviceSize: deviceSize),
                  SalesHistoryItem(deviceSize: deviceSize),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
