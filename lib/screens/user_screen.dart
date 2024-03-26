import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:SmartMicro.Mobile/screens/welcome_screen.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
const UserScreen({super.key});

  @override
State<UserScreen> createState() => _UserScreenState();
}

  class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChickiesColor.primary,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}