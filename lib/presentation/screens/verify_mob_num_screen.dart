import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/presentation/screens/calculator/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyMobNumScreen extends StatelessWidget {
  const VerifyMobNumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Mobile Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'OTP',
              ),
            ),
            const SizedBox(height: 16.0),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is LoggedInState) {
                  // print("Verify Otp Screen, User: ${state.user} ");
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Calculator(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FilledButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.tertiary,
                    )),
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(VerifyCodeEvent(code: otpController.text));
                    },
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
