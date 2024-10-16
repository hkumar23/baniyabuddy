import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/screens/calculator/calculator.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/sales_history_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTapped,
  });
  final int selectedIndex;
  final Function onTapped;
  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.history,
      Icons.article,
      Icons.calculate,
      Icons.star,
      Icons.settings,
    ];

    final List<String> labels = [
      AppLanguage.salesHistory,
      AppLanguage.billing,
      AppLanguage.calculator,
      AppLanguage.gemini,
      AppLanguage.settings,
    ];

    // void onItemTapped(int index) {
    //   if (index == selectedIndex) return;
    //   switch (index) {
    //     case 0:
    //       // Navigator.of(context).popUntil((route) => route.isFirst);
    //       Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(builder: (context) => const SalesHistory()));
    //       break;
    //     case 2:
    //       Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(builder: (context) => const Calculator()));
    //       break;
    //   }
    // }

    return Container(
      // padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black12,
        //     spreadRadius: 5,
        //     blurRadius: 10,
        //   ),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          return IconButton(
            onPressed: () => onTapped(index),
            icon: selectedIndex == index
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        // shape: BoxShape.circle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      children: [
                        Icon(
                          icons[index],
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          labels[index],
                          style: Theme.of(context).textTheme.labelLarge,
                        )
                      ],
                    ),
                  )
                : Icon(
                    icons[index],
                    color: Colors.white54,
                    size: 30,
                  ),
          );
        }),
      ),
    );
  }
}
