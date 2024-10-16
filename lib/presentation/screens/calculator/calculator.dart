import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/presentation/screens/authentication/email/sign_in_with_email.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/sales_history_screen.dart';
import 'package:baniyabuddy/presentation/screens/authentication/sign_in_screen.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/display/calc_display.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/keyboard/calc_keyboard.dart';
import 'package:baniyabuddy/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),

        //   body:
        BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoggedOutState) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SignInWithEmailScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return const Column(
          children: [
            Expanded(
              flex: 1,
              child: CalcDisplay(),
            ),
            Expanded(
              flex: 2,
              child: CalcKeyBoard(),
            ),
          ],
        );
      },
      // ),
    );
  }
}
