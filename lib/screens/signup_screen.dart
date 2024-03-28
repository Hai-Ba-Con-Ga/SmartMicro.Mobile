import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Button/button.dart';
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
      // drawerScrimColor: ChickiesColor.primary,
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontSize: 30, color: Colors.white)),
        centerTitle: true,
        backgroundColor: ChickiesColor.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: ChickiesColor.purple2,
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.white),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: ChickiesColor.purple2,
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.white),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10.0),
                        TextField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: ChickiesColor.purple2,
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.white),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
      //* Sign Up Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ChickiesButton(
          reversedColor: true,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigatorBar()),
              (route) => false,
            );
          },
          text: 'Sign Up',
        ),
      ),
    );
  }
}