import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_bloc.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_state.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/display/i_o_display_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcDisplay extends StatelessWidget {
  const CalcDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    // final appBarHeight = AppBar().preferredSize.height;
    return BlocConsumer<CalculatorBloc, CalculatorState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          // color: Colors.red.shade300,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IODisplayItem(
                flex: 3,
                backgroundColor: Colors.black.withOpacity(0.2),
                alignment: Alignment.bottomLeft,
                scrollController: null,
                expression: state.output!,
                mainAxisAlignment: MainAxisAlignment.start,
                fontSize: 50,
              ),
              IODisplayItem(
                flex: 2,
                backgroundColor: Colors.transparent,
                alignment: Alignment.bottomRight,
                scrollController: state.scrollController,
                expression: state.inputExpression!,
                mainAxisAlignment: MainAxisAlignment.end,
                fontSize: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
