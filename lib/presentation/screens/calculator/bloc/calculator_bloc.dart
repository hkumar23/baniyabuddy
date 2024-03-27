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
            int.parse(AppMethods.removeLastChar(state.inputExpression)),
            event.number,
            lastChar,
          );
          print("newOutput: $newOutput");
          emit(CalculatorState(
            inputExpression: state.inputExpression + event.number.toString(),
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
      String op = event.operator;
      int inputSize = state.inputExpression.length;
      String lastChar =
          inputSize > 0 ? state.inputExpression[inputSize - 1] : "";
      if (op == 'a') {
        emit(CalculatorState(
          inputExpression: "",
          output: "",
        ));
      } else if (op == 'd') {
        emit(CalculatorState(
          inputExpression: inputSize > 0
              ? AppMethods.removeLastChar(state.inputExpression)
              : "",
          output: state.output,
        ));
      }
      if (op == '=') {
        emit(CalculatorState(
          inputExpression: "",
          output: state.output,
        ));
      } else if (state.inputExpression == "") {
        print("When inputExpression is empty");
        emit(CalculatorState(
          inputExpression: state.inputExpression,
          output: state.output,
        ));
      } else if (AppMethods.isOperator(lastChar)) {
        print("when there is already an operator");
        String newInput = AppMethods.removeLastChar(state.inputExpression);
        newInput += event.operator;
        emit(CalculatorState(
          inputExpression: newInput,
          output: state.output,
        ));
      } else {
        print("when there is no operator");

        emit(CalculatorState(
          inputExpression: state.inputExpression + event.operator,
          output: state.output,
        ));
      }
    });
    // on<NumberPressedEvent>((event, emit) {
    //   return emit(
    //     CalculatorState(
    //         inputExpression: "InputExpression", output: "Number Pressed"),
    //   );
    // });
  }
}
