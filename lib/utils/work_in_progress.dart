import 'package:flutter/material.dart';

class WorkInProgress extends StatelessWidget {
  const WorkInProgress({
    required this.color,
    super.key,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // color: Colors.red,
          alignment: Alignment.center,
          height: 150,
          child: Image.network(
            "https://cdn-icons-png.freepik.com/512/9483/9483028.png",
            fit: BoxFit.contain,
            color: color,
          ),
        ),
        Text("Work In Progress",
            style: TextStyle(
              fontSize: 25,
              color: color,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
