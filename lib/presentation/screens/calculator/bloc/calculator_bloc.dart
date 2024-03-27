import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_event.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_state.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:bloc/bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState(inputExpression: "", output: "")) {
    on<NumberPressedEvent>((event, emit) {
      int inputSize = state.inputExpression.length;
      String lastChar =
          inputSize > 0 ? state.inputExpression[inputSize - 1] : "";
      if (state.inputExpression == "") {
        emit(CalculatorState(
          inputExpression: event.number.toString(),
          output: state.output,
        ));
      } else if (!AppMethods.isOperator(lastChar)) {
        emit(CalculatorState(
          inputExpression: state.inputExpression += event.number.toString(),
          output: state.output,
        ));
      } else {
        if (state.output == "") {
          String newOutput = AppMethods.calculateResult(
            AppMethods.removeLastChar(state.inputExpression) as int,
            event.number.toString() as int,
            lastChar,
          );
          emit(CalculatorState(
            inputExpression: state.inputExpression += event.number.toString(),
            output: newOutput,
          ));
        } else {
          String newOutput = AppMethods.calculateResult(
            int.parse(state.output),
            event.number,
            lastChar,
          );
          emit(CalculatorState(
            inputExpression: state.inputExpression += event.number.toString(),
            output: newOutput,
          ));
        }
      }
    });
    on<OperatorPressedEvent>((event, emit) {
      emit(CalculatorState(
          inputExpression: "InputExpression", output: "Operator Pressed"));
    });
    // on<NumberPressedEvent>((event, emit) {
    //   return emit(
    //     CalculatorState(
    //         inputExpression: "InputExpression", output: "Number Pressed"),
    //   );
    // });
  }
}
