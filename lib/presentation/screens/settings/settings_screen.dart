import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_bloc.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/settings_bloc.dart';
import 'bloc/settings_state.dart';
import 'bloc/settings_event.dart';
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
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsErrorState) {
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
        if (state is BusinessInfoSavedState) {
          CustomSnackbar.success(
            context: context,
            text: "Business Details saved successfully !!",
          );
        }
        if (state is UpiIdSavedState) {
          CustomSnackbar.success(
            context: context,
            text: "UPI ID saved successfully !!",
          );
        }
      },
      builder: (context, state) {
        // print(auth?.photoURL);
        // print(auth?.displayName);
        final deviceSize = MediaQuery.of(context).size;
        if (state is SettingsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (ctx, authState) {
            if (authState is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: deviceSize.height * 0.05,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: auth?.photoURL == null
                              ? const NetworkImage(
                                  'https://i.pinimg.com/736x/c4/c2/34/c4c23420aa097fcb949a3011eddeab3b.jpg')
                              : NetworkImage(auth!.photoURL!),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auth?.displayName == null ||
                                      auth?.displayName == ""
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
                            GestureDetector(
                              onTap: () {
                                showAdaptiveDialog(
                                    context: context,
                                    builder: (context) {
                                      // TODO: Add Edit Profile Dialog
                                      return const AlertDialog();
                                    });
                              },
                              child: Container(
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
                              ),
                            )
                          ],
                        ),
                      ],
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
                        context
                            .read<SettingsBloc>()
                            .add(SyncDataWithFirebaseEvent());
                      },
                      title: const Text('Sync Data'),
                      trailing: state is SyncDataLoadingState
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
