import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/presentation/screens/authentication/verify_mob_num_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController? phoneNumController;

  @override
  void initState() {
    phoneNumController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 64),
                child: Image.asset(
                  "assets/images/phone_auth_icons_1.png",
                  fit: BoxFit.contain,
                  height: deviceSize.height * 0.25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Sign In with OTP",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Container(
                width: deviceSize.width * 0.8,
                padding: const EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: 64),
                child: Text.rich(
                    TextSpan(
                      text: "We will send you an ",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                      children: const [
                        TextSpan(
                          text: "One Time Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(text: " on this mobile number"),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              SizedBox(
                width: deviceSize.width * 0.8,
                child: TextField(
                  controller: phoneNumController,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Mobile Number',
                    prefixText: '+91 ',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthCodeSentState) {
                    // print("Auth Code Sent State");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VerifyMobNumScreen(
                          phoneNumber: state.phoneNumber,
                        ),
                      ),
                    );
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
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
                    width: deviceSize.width * 0.8,
                    height: 60,
                    child: FilledButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              SendCodeEvent(
                                  phoneNumber: phoneNumController!.text),
                            );
                      },
                      child: const Text(
                        'Get OTP',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
