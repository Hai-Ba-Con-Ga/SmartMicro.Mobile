import 'package:SmartMicro.Mobile/api/client.dart';
import 'package:SmartMicro.Mobile/api/shared_prefs.dart';
import 'package:SmartMicro.Mobile/data/account.dart';
import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(text: 'nmhung@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: '123123');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChickiesColor.primary,
      // drawerScrimColor: ChickiesColor.primary,
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontSize: 30, color: Colors.white)),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: emailController,
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
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Please enter your email';
                  }
                  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!regex.hasMatch(email)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: passwordController,
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
                validator: (password) {
                  if (password == null || password.isEmpty || password.length < 6) {
                    return 'Please enter password with at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút "Forgot?"
                    },
                    child: Text('Forgot?', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              // SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      //* Login Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ChickiesButton(
          reversedColor: true,
          onPressed: _login,
          text: 'Sign in',
        ),
      ),
    );
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final response = await APIClient().login(Account(
      email: emailController.text,
      password: passwordController.text,
    ));
    if (response == null) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login failed'),
            content: Text('Please check your email and password'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    print(response);
    await SharedPrefs.setString('access_token', response['accessToken'] as String);
    await SharedPrefs.setString('userId', (response['accountId'] as int).toString());
    await SharedPrefs.setString('username', emailController.text);

    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => NavigatorBar()),
      (route) => false,
    );
  }
}
