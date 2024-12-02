import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/Blocs/Authentication/bloc/auth_bloc.dart';
import '../../../logic/Blocs/Authentication/bloc/auth_event.dart';
import '../../../logic/Blocs/Authentication/bloc/auth_state.dart';
import '../../widgets/settings_component/business_info_bottomsheet.dart';
import '../../widgets/settings_component/generate_qr_bottomsheet.dart';
import '../../widgets/settings_component/save_upi_bottomsheet.dart';
import '../../../utils/app_methods.dart';
import '../../../utils/custom_snackbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          CustomSnackbar.error(
            context: context,
            text: state.errorMessage,
          );
        }
        if (state is DataSyncedWithFirebaseState) {
          CustomSnackbar.success(
            context: context,
            text: "Data Synced Successfully !!",
          );
        }
      },
      builder: (context, state) {
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
                            ? const NetworkImage(
                                'https://via.placeholder.com/200')
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
                  title: const Text('Business Info'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const BusinessInfoBottomSheet();
                          // return Container();
                        });
                  },
                ),
                ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const SaveUpiBottomsheet();
                        });
                  },
                  title: const Text('UPI ID'),
                  subtitle: const Text('For QR Code generation'),
                  trailing: const Icon(
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
                          return const GenerateQrBottomSheet();
                        });
                  },
                ),
                ListTile(
                  onTap: () {
                    context.read<AuthBloc>().add(SyncDataWithFirebaseEvent());
                  },
                  title: const Text('Sync Data'),
                  trailing: state is AuthLoadingState
                      ? const CupertinoActivityIndicator()
                      : const Icon(
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
      },
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
