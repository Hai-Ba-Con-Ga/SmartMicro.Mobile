import 'package:SmartMicro.Mobile/screens/login_screen.dart';
import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:SmartMicro.Mobile/screens/signup_screen.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Button/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChickiesColor.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, bottom: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(image: AssetImage('assets/images/chickies_logo2.png'), height: 80),
              Text('Hi there, We are', style: TextStyle(fontSize: 20, color: ChickiesColor.background, fontWeight: FontWeight.bold)),
              Text('Smart Micro', style: TextStyle(fontSize: 40, color: ChickiesColor.background, fontWeight: FontWeight.bold)),
              Expanded(child: const SizedBox()),
              //* Login Button
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChickiesButton(
                    reversedColor: true,
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      text: 'Continue with us')),
              //* SignUp Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChickiesButton(
                    width: MediaQuery.of(context).size.width / 2,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    text: 'I am a new in here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
