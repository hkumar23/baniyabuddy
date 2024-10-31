import 'package:baniyabuddy/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/app_constants.dart';
import 'logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'logic/Blocs/Authentication/bloc/auth_state.dart';
import 'presentation/screens/authentication/email/sign_in_with_email.dart';
import 'presentation/screens/billing/bloc/billing_bloc.dart';
import 'presentation/screens/calculator/bloc/calculator_bloc.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'utils/app_methods.dart';
import 'data/models/bill_item.model.dart';
import 'data/models/invoice.model.dart';
import 'utils/hive_adapter_names.dart';
import 'utils/hive_adapter_typeids.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(InvoiceAdapter());
  Hive.registerAdapter(BillItemAdapter());
  // opening box here so that it is easily available appwide right after start
  Hive.openBox<int>("globalInvoiceNumberBox");
  Hive.openBox<Invoice>("InvoiceBox");
  // await TimeMachine.initialize({'rootBundle': rootBundle});
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed || state==AppLifecycleState.) {
    //   print(state);
    AppMethods.logUserActivity();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BillingBloc>(create: (context) => BillingBloc()),
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
              // return const Calculator();
              return const MainScreen();
            } else if (state is LoggedOutState) {
              // return const SignInScreen();
              return SignInWithEmailScreen();
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
