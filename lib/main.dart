import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/firebase_options.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_bloc.dart';
import 'package:baniyabuddy/presentation/screens/calculator/calculator.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await TimeMachine.initialize({'rootBundle': rootBundle});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<CalculatorBloc>(create: (context) => CalculatorBloc()),
        BlocProvider<SalesHistoryBloc>(create: (context) => SalesHistoryBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        // home: const SplashScreen(),
        home: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is InitialAuthState;
          },
          builder: (context, state) {
            if (state is LoggedInState) {
              // print("Main, User: ${state.user} ");
              context.read<SalesHistoryBloc>().add(FetchSalesHistoryEvent());
              return const Calculator();
            } else if (state is LoggedOutState) {
              return const SignInScreen();
            } else {
              // return const SplashScreen();
              return const Scaffold();
            }
          },
        ),
      ),
    );
  }
}
