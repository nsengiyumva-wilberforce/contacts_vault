import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({required this.title, Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value) {
            // Handle menu item selection here
            if (value == 'logout') {
              // Handle logout action
            } else if (value == 'profile_settings') {
              // Handle profile settings action
            }
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
              const PopupMenuItem<String>(
                value: 'profile_settings',
                child: Text('Profile Settings'),
              ),
            ];
          },
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ],
    );
  }
}
