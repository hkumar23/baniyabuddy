import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/widgets/sales%20history%20components/time_period_filter.dart';
import 'package:flutter/material.dart';

class TotalSalesWidget extends StatelessWidget {
  const TotalSalesWidget({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
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
                    "Total sales",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 8),
                        Text(
                          "₹ 10000",
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
  }
}
