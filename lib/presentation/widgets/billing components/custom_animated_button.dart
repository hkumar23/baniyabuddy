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
    return Container(
      padding: const EdgeInsets.all(8),
      height: 45,
      width: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black54,
              spreadRadius: 2,
            )
          ]),
      child: Text(
        'Generate Invoice',
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.onTertiary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // return AnimatedContainer(
    //   // constraints: const BoxConstraints(
    //   //   maxWidth: 150,
    //   //   minWidth: 130,
    //   //   minHeight: 45,
    //   //   maxHeight: 60,
    //   // ),
    //   height: 45,
    //   width: 140,
    //   alignment: Alignment.center,
    //   duration: duration,
    //   curve: Curves.easeInOut,
    //   decoration: BoxDecoration(
    //       color: theme.colorScheme.tertiary,
    //       border: Border.all(
    //         color: colors[index],
    //         style: BorderStyle.solid,
    //         width: 2,
    //       ),
    //       borderRadius: const BorderRadius.all(Radius.circular(50)),
    //       boxShadow: const [
    //         BoxShadow(
    //           blurRadius: 5,
    //           color: Colors.black87,
    //           spreadRadius: 2,
    //         )
    //       ]),
    //   child:
    //       // FilledButton(
    //       //   style: ButtonStyle(
    //       //     shadowColor: const WidgetStatePropertyAll(Colors.black),
    //       //     backgroundColor: WidgetStatePropertyAll(
    //       //       theme.colorScheme.tertiary,
    //       //     ),
    //       //     foregroundColor: WidgetStatePropertyAll(
    //       //       theme.colorScheme.onTertiary,
    //       //     ),
    //       //   ),
    //       //   onPressed: () {},
    //       //   child:
    //       Text(
    //     'Generate Invoice',
    //     style: theme.textTheme.titleMedium!.copyWith(
    //       color: theme.colorScheme.onTertiary,
    //       fontWeight: FontWeight.w600,
    //     ),
    //   ),
    //   // ),
    // );
  }
}
