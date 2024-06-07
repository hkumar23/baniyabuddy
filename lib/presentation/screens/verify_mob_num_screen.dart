import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/presentation/screens/calculator/calculator.dart';
import 'package:baniyabuddy/presentation/widgets/resend_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyMobNumScreen extends StatefulWidget {
  const VerifyMobNumScreen({
    required this.phoneNumber,
    super.key,
  });
  final String phoneNumber;
  @override
  State<VerifyMobNumScreen> createState() => _VerifyMobNumScreenState();
}

class _VerifyMobNumScreenState extends State<VerifyMobNumScreen> {
  TextEditingController? otpController;

  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: BackButton(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: Image.asset(
                      "assets/images/phone_auth_icons_2.png",
                      fit: BoxFit.contain,
                      height: deviceSize.height * 0.22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Sign In with OTP",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  Container(
                    width: deviceSize.width * 0.8,
                    padding: const EdgeInsets.only(
                        top: 16, left: 8, right: 8, bottom: 48),
                    child: Text.rich(
                      TextSpan(
                        text: "Enter the OTP sent to ",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        children: [
                          TextSpan(
                            text: "+91 ${widget.phoneNumber}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          // TextSpan(text: " on this mobile number"),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    width: deviceSize.width * 0.8,
                    child: TextField(
                      controller: otpController,
                      maxLength: 6,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'OTP',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthErrorState) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(state.errorMessage),
                        //     backgroundColor: Colors.red,
                        //   ),
                        // );
                      } else if (state is LoggedInState) {
                        // print("Verify Otp Screen, User: ${state.user} ");
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
                        width: deviceSize.width * 0.8,
                        height: 60,
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // Rounded corners
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  VerifyCodeEvent(code: otpController!.text),
                                );
                          },
                          child: const Text(
                            'Verify & Sign In',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            ResendOTP(
              phoneNumber: widget.phoneNumber,
            ),
          ],
        ),
      ),
    );
  }
}
