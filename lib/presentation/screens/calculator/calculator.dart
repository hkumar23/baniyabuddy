import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/presentation/screens/authentication/email/sign_in_with_email.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/sales_history_screen.dart';
import 'package:baniyabuddy/presentation/screens/authentication/sign_in_screen.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/display/calc_display.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/keyboard/calc_keyboard.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
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
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SalesHistory();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.history_rounded),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  AppMethods.logoutWithDialog(context);
                },
                icon: const Icon(
                  Icons.logout,
                  // color: Colors.red,
                ),
              ),
            ],
            forceMaterialTransparency: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   "assets/logo/baniya_buddy_logo.png",
                //   fit: BoxFit.contain,
                //   height: 32,
                // ),
                Text(
                  AppLanguage.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            centerTitle: true,
            // backgroundColor: Colors.grey.shade300,
          ),
          body: const Column(
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
          ),
        );
      },
    );
  }
}
