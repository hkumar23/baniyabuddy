import 'dart:async';
import 'package:flutter/material.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({super.key});

  @override
  State<CustomAnimatedButton> createState() {
    return _CustomAnimatedButtonState();
  }
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton> {
  int index = 0;
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple
  ];
  Duration duration = const Duration(milliseconds: 250);
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    // set up a timer, make state changes, and redraw.
    _timer = Timer.periodic(duration, (timer) {
      index = (index + 1) % colors.length;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    // make sure to dispose of the timer when you're done.
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      height: 45,
      width: 130,
      alignment: Alignment.center,
      duration: duration,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          border: Border.all(
            color: colors[index],
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black87,
              spreadRadius: 2,
            )
          ]),
      child:
          // FilledButton(
          //   style: ButtonStyle(
          //     shadowColor: const WidgetStatePropertyAll(Colors.black),
          //     backgroundColor: WidgetStatePropertyAll(
          //       theme.colorScheme.tertiary,
          //     ),
          //     foregroundColor: WidgetStatePropertyAll(
          //       theme.colorScheme.onTertiary,
          //     ),
          //   ),
          //   onPressed: () {},
          //   child:
          Text(
        'Generate Pdf',
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.onTertiary,
        ),
      ),
      // ),
    );
  }
}
