import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_bloc.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_state.dart';
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
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  // softWrap: true,
                  // textAlign: TextAlign.left,
                  state.output,
                  style: const TextStyle(fontSize: 50),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  // softWrap: true,
                  // textAlign: TextAlign.right,
                  state.inputExpression,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
