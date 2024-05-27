import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/presentation/screens/sign_in_screen.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/display/calc_display.dart';
import 'package:baniyabuddy/presentation/widgets/calc%20components/keyboard/calc_keyboard.dart';
import 'package:baniyabuddy/utils/work_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoggedOutState) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.logout),
                    onTap: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                  )
                ],
              );
            },
          )
          // const WorkInProgress(
          //   color: Colors.black,
          // ),
          ),
      appBar: AppBar(
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
  }
}
