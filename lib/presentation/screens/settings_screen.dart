import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:baniyabuddy/utils/generate_qr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: auth?.photoURL == null
                        ? const NetworkImage('https://via.placeholder.com/200')
                        : NetworkImage(auth!.photoURL!),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        auth?.displayName == null
                            ? "Your Name"
                            : auth!.displayName!,
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        auth?.email as String,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Edit Profile",
                          style: theme.textTheme.labelMedium,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Edit business information'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog();
                    });
              },
            ),
            const ListTile(
              title: Text('UPI ID'),
              subtitle: Text('For QR Code generation'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
            ListTile(
              title: const Text('Generate QR Code'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        onClosing: () {},
                        builder: (context) => Container(
                          height: 250,
                          padding: const EdgeInsets.all(50),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text("Enter Amount"),
                            ),
                            onSubmitted: (value) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (context) => GenerateQr(
                                        upiId: "9873541772@ptsbi",
                                        businessName: "Codeworks Infinity",
                                        amount: value,
                                      ));
                            },
                          ),
                        ),
                      );
                    });
              },
            ),
            const ListTile(
              title: Text('Sync Data'),
              trailing: Icon(
                Icons.sync,
                size: 20,
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(
                Icons.logout,
                size: 20,
              ),
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () {
                AppMethods.logoutWithDialog(context);
              },
            )
            // buildListTile('Privacy', onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
