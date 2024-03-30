import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_event.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_state.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:bloc/bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState(inputExpression: "", output: "")) {
    on<NumberPressedEvent>((event, emit) {
      state.scrollController
          .jumpTo(state.scrollController.position.maxScrollExtent);

      String newInputExpression =
          state.inputExpression + event.number.toString();
      String newOutput = AppMethods.calculateResult(newInputExpression);
      emit(CalculatorState(
        inputExpression: newInputExpression,
        output: newOutput,
      ));
    });
    on<OperatorPressedEvent>((event, emit) {
      state.scrollController
          .jumpTo(state.scrollController.position.maxScrollExtent);
      String op = event.operator;
      int inputSize = state.inputExpression.length;
      String lastChar =
          inputSize > 0 ? state.inputExpression[inputSize - 1] : "";
      if (inputSize <= 0) {
        if (op == '-') {
          emit(CalculatorState(
            inputExpression: op,
            output: "",
          ));
        } else {
          emit(CalculatorState(
            inputExpression: "",
            output: "",
          ));
        }
      } else {
        if (op == 'a') {
          emit(CalculatorState(
            inputExpression: "",
            output: "",
          ));
        } else if (op == 'd') {
          String newInputExpression =
              AppMethods.removeLastChar(state.inputExpression);
          String newOutput = "";

          if (newInputExpression.isNotEmpty) {
            String lastChar = newInputExpression[newInputExpression.length - 1];
            if (AppMethods.isOperator(lastChar)) {
              newInputExpression =
                  AppMethods.removeLastChar(newInputExpression);
              newOutput = AppMethods.calculateResult(newInputExpression);
              newInputExpression += lastChar;
            } else {
              newOutput = AppMethods.calculateResult(newInputExpression);
            }
          }
          emit(CalculatorState(
            inputExpression: newInputExpression,
            output: newOutput,
          ));
        } else if (op == '=') {
          String newInputExpression = state.inputExpression;
          if (AppMethods.isOperator(lastChar)) {
            newInputExpression = AppMethods.removeLastChar(newInputExpression);
          }
          String newOutput = AppMethods.calculateResult(newInputExpression);
          emit(CalculatorState(
            inputExpression: newOutput,
            output: newOutput,
          ));
        } else if (op == '.' &&
            (lastChar == '.' || AppMethods.isOperator(lastChar))) {
          String newInputExpression =
              AppMethods.removeLastChar(state.inputExpression) + op;
          emit(CalculatorState(
            inputExpression: newInputExpression,
            output: state.output,
          ));
        } else if (op == '.') {
          emit(CalculatorState(
            inputExpression: state.inputExpression + op,
            output: state.output,
          ));
        } else if (AppMethods.isOperator(lastChar)) {
          String newInputExpression =
              AppMethods.removeLastChar(state.inputExpression) + op;
          if (lastChar == '-' && inputSize == 1) {
            newInputExpression = '-';
          }
          emit(CalculatorState(
            inputExpression: newInputExpression,
            output: state.output,
          ));
        } else {
          emit(CalculatorState(
            inputExpression: state.inputExpression + event.operator,
            output: state.output,
          ));
        }
      }
    });
  }

  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }
}
