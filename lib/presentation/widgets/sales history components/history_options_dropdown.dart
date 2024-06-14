import 'package:flutter/material.dart';

class HistoryOptionsDropDown extends StatefulWidget {
  const HistoryOptionsDropDown({super.key});

  @override
  State<HistoryOptionsDropDown> createState() => _HistoryOptionsDropDownState();
}

class _HistoryOptionsDropDownState extends State<HistoryOptionsDropDown> {
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
  String selectedOption = "Today";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        value: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value.toString();
          });
        },
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        underline: Container(
          color: Colors.transparent,
        ),
        // borderRadius: BorderRadius.circular(10),
        // style: TextStyle(
        //   color: Theme.of(context).colorScheme.surface,
        //   fontWeight: FontWeight.bold,
        // ),
        // icon: Icon(
        //   Icons.arrow_drop_down,
        //   color: Theme.of(context).colorScheme.surface,
        // ),
        isDense: true,
        // dropdownColor: Theme.of(context).colorScheme.secondaryContainer,
        // items: const [
        //   DropdownMenuItem(
        //     value: "Month",
        //     child: Text("Month"),
        //   ),
        //   DropdownMenuItem(
        //     value: "3 Months",
        //     child: Text("3 Months"),
        //   ),
        //   DropdownMenuItem(
        //     value: "6 Months",
        //     child: Text("6 Months"),
        //   ),
        //   DropdownMenuItem(
        //     value: "Year",
        //     child: Text("Year"),
        //   ),
        // ],
        items: dropdownOptions.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
    // return GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       isDropdownOpen = !isDropdownOpen;
    //     });
    //   },
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
    //         decoration: BoxDecoration(
    //           color: Theme.of(context).colorScheme.primary,
    //           borderRadius: BorderRadius.circular(10),
    //           // border: Border.all(
    //           //   color: Theme.of(context).colorScheme.onSurface,
    //           // ),
    //         ),
    //         child: Row(
    //           children: [
    //             Text(
    //               selectedOption,
    //               style: TextStyle(
    //                 color: Theme.of(context).colorScheme.surface,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             Icon(
    //               Icons.arrow_drop_down,
    //               color: Theme.of(context).colorScheme.surface,
    //             ),
    //           ],
    //         ),
    //       ),
    //       if (isDropdownOpen)
    //         Container(
    //           margin: const EdgeInsets.only(top: 4),
    //           padding: const EdgeInsets.symmetric(vertical: 8),
    //           decoration: BoxDecoration(
    //             border: Border.all(color: Colors.grey),
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: Column(
    //             children: dropdownOptions.map((String option) {
    //               return GestureDetector(
    //                 onTap: () {
    //                   setState(() {
    //                     selectedOption = option;
    //                     isDropdownOpen = false;
    //                   });
    //                   // Perform any additional actions upon selecting an option
    //                 },
    //                 child: Container(
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: 12, vertical: 8),
    //                   child: Text(option),
    //                 ),
    //               );
    //             }).toList(),
    //           ),
    //         ),
    //     ],
    //   ),
    // );
  }
}
