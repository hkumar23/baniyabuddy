import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_bloc.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_event.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/keyboard/calc_button.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/keyboard/save_transaction_dialog.dart';
import 'package:baniyabuddy/utils/work_in_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcKeyBoard extends StatelessWidget {
  const CalcKeyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    // final appBarHeight = AppBar().preferredSize.height;

    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 5,
      ),
      // color: const Color.fromARGB(255, 211, 246, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CalcButton(
                  buttonColor: Theme.of(context).colorScheme.primaryContainer,
                  subject: Icons.save,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (dialogContext) {
                          // return AlertDialog(
                          //   contentPadding: const EdgeInsets.all(20),
                          //   content: WorkInProgress(
                          //     color: Theme.of(context)
                          //         .colorScheme
                          //         .onSecondaryContainer,
                          //   ),
                          // );
                          return BlocProvider.value(
                            value: BlocProvider.of<CalculatorBloc>(context),
                            child: const SaveTransactionDialog(),
                          );
                        });
                  },
                ),
                CalcButton(
                  buttonColor: Theme.of(context).colorScheme.inverseSurface,
                  subject: AppLanguage.ac,
                  textColor: Theme.of(context).colorScheme.surface,
                  onPressed: () {
                    // BlocProvider.of<CalculatorBloc>(context)
                    //     .add(OperatorPressedEvent(operator: 'a'));
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: 'a'));
                  },
                ),
                CalcButton(
                  buttonColor: Theme.of(context).colorScheme.inverseSurface,
                  subject: CupertinoIcons.percent,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: '%'));
                  },
                ),
                CalcButton(
                  buttonColor: Theme.of(context).colorScheme.inverseSurface,
                  subject: CupertinoIcons.divide,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: '/'));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.seven,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 7));
                  },
                ),
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.eight,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 8));
                  },
                ),
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.nine,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    // print('9');
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 9));
                  },
                ),
                CalcButton(
                  buttonColor: Theme.of(context).colorScheme.inverseSurface,
                  subject: Icons.clear,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: '*'));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.four,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 4));
                  },
                ),
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.five,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 5));
                  },
                ),
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.six,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 6));
                  },
                ),
                CalcButton(
                  buttonColor: Theme.of(context).colorScheme.inverseSurface,
                  subject: Icons.remove,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: '-'));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.one,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 1));
                  },
                ),
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.two,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 2));
                  },
                ),
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.three,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 3));
                  },
                ),
                CalcButton(
                  buttonColor: Theme.of(context).colorScheme.inverseSurface,
                  subject: CupertinoIcons.add,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: '+'));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.dot,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: '.'));
                  },
                ),
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: AppLanguage.zero,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressedEvent(number: 0));
                  },
                ),
                CalcButton(
                  buttonColor: Colors.transparent,
                  subject: Icons.backspace_rounded,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: 'd'));
                  },
                ),
                CalcButton(
                  buttonColor: Theme.of(context).colorScheme.inverseSurface,
                  subject: CupertinoIcons.equal,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressedEvent(operator: '='));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
