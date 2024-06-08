import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_bloc.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_state.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/display/i_o_display_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcDisplay extends StatelessWidget {
  const CalcDisplay({super.key});
  // ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    // final appBarHeight = AppBar().preferredSize.height;
    return BlocConsumer<CalculatorBloc, CalculatorState>(
      listener: (context, state) {
        if (state is SaveTransactionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "Transaction saved successfully! ",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ));
        } else if (state is CalcErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Transaction not saved: ${state.errorMessage}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
        }
      },
      builder: (context, state) {
        // scrollController.jumpTo(scrollController.position.maxScrollExtent);
        // state.scrollController
        //     .jumpTo(state.scrollController.position.maxScrollExtent);

        return Container(
          // color: Colors.red.shade300,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IODisplayItem(
                flex: 3,
                backgroundColor: Colors.black.withOpacity(0.4),
                // alignment: Alignment.bottomLeft,
                scrollController: null,
                expression: state.output,
                // mainAxisAlignment: MainAxisAlignment.end,
                fontSize: 50,
                isUpperDisplay: true,
              ),
              IODisplayItem(
                flex: 2,
                backgroundColor: Colors.transparent,
                // alignment: Alignment.bottomRight,
                scrollController: state.scrollController,
                expression: state.inputExpression,
                // mainAxisAlignment: MainAxisAlignment.start,
                fontSize: 30,
                isUpperDisplay: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
