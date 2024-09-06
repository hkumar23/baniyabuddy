import 'package:baniyabuddy/presentation/screens/authentication/email/sign_up_with_email.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInWithEmailScreen extends StatelessWidget {
  const SignInWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/logo/baniya_buddy_logo.png",
                    height: 100,
                  ),
                  Text(
                    "Baniya Buddy",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Text(
                  'Login to your Account',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              Container(
                width: double.infinity,
                height: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    textStyle: WidgetStateProperty.all(
                        Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onPrimary),
                  ),
                  onPressed: () {},
                  child: const Text('Sign in'),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SignUpWithEmailScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Or',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("Sign in with Google");
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 55,
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google_logo.png",
                        height: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // FilledButton(
              //   onPressed: () {},
              //   style: ButtonStyle(
              //     maximumSize: const WidgetStatePropertyAll(Size(800, 50)),
              //     padding: const WidgetStatePropertyAll(
              //         EdgeInsets.symmetric(horizontal: 26, vertical: 12)),
              //     backgroundColor:
              //         const WidgetStatePropertyAll(Colors.transparent),
              //     foregroundColor: WidgetStatePropertyAll(
              //         Theme.of(context).colorScheme.onSurface),

              // elevation: const WidgetStatePropertyAll(5),
              // shadowColor:
              //     WidgetStatePropertyAll(Colors.black.withOpacity(0.5)),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     mainAxisSize: MainAxisSize.min,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         "assets/images/google_logo.png",
              //         fit: BoxFit.fitHeight,
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       const Text(
              //         "Sign in with Google",
              //         style: TextStyle(
              //           fontSize: 18,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
