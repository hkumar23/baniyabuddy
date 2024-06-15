import 'package:baniyabuddy/constants/app_language.dart';
import 'package:flutter/material.dart';

import 'filter_item.dart';

class FiltersRow extends StatefulWidget {
  const FiltersRow({
    super.key,
  });

  @override
  State<FiltersRow> createState() => _FiltersRowState();
}

class _FiltersRowState extends State<FiltersRow> {
  String _selectedFilter = AppLanguage.all;
  void onTap(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
