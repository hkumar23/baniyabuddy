import 'package:baniyabuddy/presentation/widgets/sales%20history%20components/history_options_dropdown.dart';
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
                        "Welcome back!",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "Our Valued User",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total sales",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      // const SizedBox(height: 8),
                      Text(
                        "₹ 10000",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const HistoryOptionsDropDown(),
                ],
              ),
            ),
          ],
        ));
  }
}
