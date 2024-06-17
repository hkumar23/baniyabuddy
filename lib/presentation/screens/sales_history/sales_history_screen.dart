import 'package:flutter/material.dart';

import '../../../constants/app_language.dart';
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
                  padding: const EdgeInsets.only(top: 5, left: 4, bottom: 5),
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
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Search with Name / Phone Number",
                                filled: true,
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.1),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
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
                    child: Column(
                      children: [
                        SalesHistoryItem(deviceSize: deviceSize),
                        SalesHistoryItem(deviceSize: deviceSize),
                        SalesHistoryItem(deviceSize: deviceSize),
                        SalesHistoryItem(deviceSize: deviceSize),
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
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
