import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/presentation/screens/verify_mob_num_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In with Phone Number'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneNumController,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mobile Number',
                prefixText: '+91 ',
              ),
            ),
            const SizedBox(height: 16.0),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthCodeSentState) {
                  // print("Auth Code Sent State");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VerifyMobNumScreen()));
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
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            SendCodeEvent(
                                phoneNumber: "+91${phoneNumController.text}"),
                          );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
