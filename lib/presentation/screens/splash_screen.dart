import 'package:baniyabuddy/constants/app_language.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/baniya_buddy_logo.png",
              fit: BoxFit.contain,
              height: deviceSize.height * 0.2,
            ),
            Text(
              AppLanguage.baniyaBuddy,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 100),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
