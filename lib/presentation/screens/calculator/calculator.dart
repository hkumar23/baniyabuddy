import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/display/calc_display.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/keyboard/calc_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        // forceMaterialTransparency: true,
        title: Text(
          AppLanguage.appName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        // backgroundColor: Colors.grey.shade300,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: CalcDisplay(),
          ),
          const Expanded(
            flex: 2,
            child: CalcKeyBoard(),
          ),
        ],
      ),
    );
  }
}
