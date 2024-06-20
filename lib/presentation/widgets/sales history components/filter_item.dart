import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final String title;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(
        title == AppLanguage.others ? AppLanguage.notSelected : title,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(
          //   color: isSelected
          //       ? Colors.transparent
          //       : Theme.of(context).colorScheme.outline,
          // ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
        ),
      ),
    );
  }
}
