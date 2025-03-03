import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/repositories/transaction_repo.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_event.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_state.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  CalculatorBloc() : super(InitialCalculatorState()) {
    on<SaveTransactionEvent>(_onSaveTransactionEvent);
    on<NumberPressedEvent>(_onNumberPressedEvent);
    on<OperatorPressedEvent>(_onOperatorPressedEvent);
  }
  void _onSaveTransactionEvent(event, emit) async {
    try {
      emit(CalcLoadingState());
      // bool isConnected = await AppMethods.checkInternetConnection();
      // if (!isConnected) {
      //   throw "You are not connected to the internet!";
      // }
      if (AppMethods.isNegative(event.transactionDetails.totalAmount!)) {
        throw "You can't add a negative transaction!";
      }
      TransactionRepo transactionRepo = TransactionRepo();
      await transactionRepo.addTransaction(event.transactionDetails);
      bool isConnected = await AppMethods.checkInternetConnection();
      if (!isConnected) {
        emit(TransactionSavedState(message: AppLanguage.savedLocally));
      } else {
        emit(TransactionSavedState(message: "Sale recorded successfully!"));
      }
      return;
    } catch (err) {
      emit(CalcErrorState(errorMessage: err.toString()));
      return;
    }
  }

  void _onNumberPressedEvent(event, emit) {
    state.scrollController
        .jumpTo(state.scrollController.position.maxScrollExtent);

    String newInputExpression = state.inputExpression + event.number.toString();
    String tempExp = newInputExpression.replaceAll("%", "*0.01*");
    String newOutput = AppMethods.calculateResult(tempExp);
    // state.scrollController
    //     .jumpTo(state.scrollController.position.maxScrollExtent);
    emit(EvaluateExpressionState(
      inputExp: newInputExpression,
      outputExp: newOutput,
    ));
  }

  void _onOperatorPressedEvent(event, emit) {
    state.scrollController
        .jumpTo(state.scrollController.position.maxScrollExtent);
    String op = event.operator;
    int inputSize = state.inputExpression.length;
    String lastChar = inputSize > 0 ? state.inputExpression[inputSize - 1] : "";
    if (inputSize <= 0) {
      if (op != '-') return;
      emit(EvaluateExpressionState(
        inputExp: op,
        outputExp: "",
      ));
    } else {
      if (op == 'a') {
        emit(EvaluateExpressionState(
          inputExp: "",
          outputExp: "",
        ));
      } else if (op == 'd') {
        String newInputExpression =
            AppMethods.removeLastChar(state.inputExpression);
        String newOutput = "";
        if (newInputExpression.isNotEmpty) {
          String lastChar = newInputExpression[newInputExpression.length - 1];
          if (AppMethods.isOperator(lastChar)) {
            newInputExpression = AppMethods.removeLastChar(newInputExpression);
            String tempExp = newInputExpression.replaceAll("%", "*0.01*");
            newOutput = AppMethods.calculateResult(tempExp);
            newInputExpression += lastChar;
          } else {
            String tempExp = newInputExpression.replaceAll("%", "*0.01*");
            newOutput = AppMethods.calculateResult(tempExp);
          }
        }
        emit(EvaluateExpressionState(
          inputExp: newInputExpression,
          outputExp: newOutput,
        ));
      } else if (op == '=') {
        String newInputExpression = state.inputExpression;
        if (AppMethods.isOperator(lastChar)) {
          newInputExpression = AppMethods.removeLastChar(newInputExpression);
        }
        String tempExp = newInputExpression.replaceAll("%", "*0.01*");
        String newOutput = AppMethods.calculateResult(tempExp);
        emit(
          EvaluateExpressionState(
            outputExp: newOutput,
            inputExp: newOutput,
          ),
        );
      } else if (op == '.' &&
          (lastChar == '.' || AppMethods.isOperator(lastChar))) {
        String newInputExpression =
            AppMethods.removeLastChar(state.inputExpression) + op;
        emit(EvaluateExpressionState(
          inputExp: newInputExpression,
          outputExp: state.output,
        ));
      } else if (op == '.') {
        // Check if the current operand already contains a decimal point
        bool operandContainsDecimal = false;
        int indexOfOperator =
            state.inputExpression.lastIndexOf(RegExp(r'[+\-*/]'));

        String currentOperand =
            state.inputExpression.substring(indexOfOperator + 1);
        operandContainsDecimal = currentOperand.contains('.');

        // If the current operand already contains a decimal point, don't add another one
        if (operandContainsDecimal) {
          return;
        }

        // Otherwise, append the decimal point to the input expression
        emit(EvaluateExpressionState(
          inputExp: state.inputExpression + op,
          outputExp: state.output,
        ));
      } else if (AppMethods.isOperator(lastChar)) {
        String newInputExpression =
            AppMethods.removeLastChar(state.inputExpression) + op;
        if (lastChar == '-' && inputSize == 1) {
          newInputExpression = '-';
        }
        emit(EvaluateExpressionState(
          inputExp: newInputExpression,
          outputExp: state.output,
        ));
      } else {
        emit(EvaluateExpressionState(
          inputExp: state.inputExpression + op,
          outputExp: state.output,
        ));
      }
    }
  }

  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }
}
