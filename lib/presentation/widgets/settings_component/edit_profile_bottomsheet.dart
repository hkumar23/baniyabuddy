import 'package:baniyabuddy/data/repositories/user_repo.dart';
import 'package:flutter/material.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({
    super.key,
  });

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final bottomViewInsets = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
        padding: EdgeInsets.only(
          bottom: bottomViewInsets + 20,
          left: 30,
          right: 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () {},
                child: Text(
                  "Update",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ProfileImageWidget(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Full Name",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2),
              color: Colors.transparent,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withOpacity(0.1),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ));
  }
}

class ProfileImageWidget extends StatelessWidget {
  ProfileImageWidget({
    super.key,
  });

  final profileImage = UserRepo().getProfileImage();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 250,
      width: double.infinity,
      // color: Colors.grey,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Align(
              //   alignment: Alignment.center,
              //   child:
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: theme.colorScheme.onPrimary,
                    // .withOpacity(0.8),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: profileImage == null
                          ? Image.asset(
                              'assets/images/profile_image.jpg',
                              fit: BoxFit.cover,
                            ).image
                          : NetworkImage(profileImage!),
                    ),
                  ],
                ),
              ),
              // ),
              Align(
                alignment: const Alignment(0.23, 1),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: theme.colorScheme.onPrimary,
                      // .withOpacity(0.8),
                      width: 2,
                    ),
                    color: theme.colorScheme.secondary,
                  ),
                  child: Image.asset(
                    'assets/images/underline-button.png',
                    height: 20,
                    width: 20,
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Upload new image",
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
