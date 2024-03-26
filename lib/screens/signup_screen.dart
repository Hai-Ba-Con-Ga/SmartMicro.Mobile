import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
const SignUpScreen({super.key});

  @override
State<SignUpScreen> createState() => _SignUpScreenState();
}

  class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChickiesColor.primary,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigatorBar()),
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}