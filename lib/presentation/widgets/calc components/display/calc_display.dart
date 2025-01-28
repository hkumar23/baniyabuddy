import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_bloc.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_state.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/display/i_o_display_item.dart';
import 'package:baniyabuddy/utils/custom_snackbar.dart';
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
        if (state is TransactionSavedState) {
          context.read<SalesHistoryBloc>().add(FetchSalesHistoryEvent());
          CustomSnackbar.success(
            context: context,
            text: state.message,
          );
        } else if (state is CalcErrorState) {
          CustomSnackbar.error(
            context: context,
            text: "Sale not recorded: ${state.errorMessage}",
          );
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
