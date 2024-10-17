import 'package:baniyabuddy/constants/app_language.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTapped,
  });
  final int selectedIndex;
  final Function onTapped;
  final List<IconData> icons = [
    Icons.history,
    // MdiIcons.cashRegister,
    // Icons.description,
    // MdiIcons.currencyInr,
    MdiIcons.fileDocument,
    Icons.calculate,
    MdiIcons.star,
    Icons.settings,
  ];
  final List<String> labels = [
    AppLanguage.salesHistory,
    AppLanguage.billing,
    AppLanguage.calculator,
    AppLanguage.gemini,
    AppLanguage.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(30),
        //   topRight: Radius.circular(30),
        // ),
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
          return buildNavItem(index, context);
        }),
      ),
    );
  }

  Widget buildNavItem(int index, BuildContext context) {
    bool isSelected = selectedIndex == index;
    final deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: isSelected ? const EdgeInsets.symmetric(horizontal: 5) : null,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isSelected
              ? Theme.of(context).colorScheme.onPrimary
              : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            if (index != 3)
              Icon(
                icons[index],
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white54,
                size: deviceWidth * 0.08,
              )
            else
              Image.asset(
                "assets/images/christmas-stars.png",
                height: deviceWidth * 0.08,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white54,
              ),
            if (isSelected) const SizedBox(width: 5),
            if (isSelected)
              Text(
                labels[index],
                style: Theme.of(context).textTheme.labelLarge,
              )
          ],
        ),
      ),
    );
  }
}
