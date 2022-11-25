import 'package:flutter/material.dart';
import 'package:socket_flutter/screens/friend_list_screen.dart';
import 'package:socket_flutter/screens/home_screen.dart';
import 'package:socket_flutter/screens/settings_screen.dart';
import 'package:socket_flutter/utils/show_toast.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selectedIndex = 0;
  Widget pageBuilder() {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const FriendListScreen();
      case 2:
        return const Text("Story");
      case 3:
        return const SettingsScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pageBuilder()),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index == 2) {
            showToast(context, "This feature is not available yet", "info");
          } else {
            setState(() {
              selectedIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage('assets/images/user_2.png'),
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
