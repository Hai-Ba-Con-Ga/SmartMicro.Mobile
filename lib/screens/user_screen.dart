import 'package:SmartMicro.Mobile/api/shared_prefs.dart';
import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:SmartMicro.Mobile/screens/voice/bloc/voice_bloc.dart';
import 'package:SmartMicro.Mobile/screens/voice/test_widget.dart';
import 'package:SmartMicro.Mobile/screens/welcome_screen.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Button/button.dart';
import 'package:chickies_ui/Components/Container/rounded_container.dart';
import 'package:chickies_ui/chickies_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String username = 'Username';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    final res = await SharedPrefs.getString('username') ?? 'Username';
    setState(() {
      username = res.split('@').first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChickiesColor.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RoundedContainer(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    color: ChickiesColor.primary,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  // padding: const EdgeInsets.all(0),
                  child: Center(child: Icon(Icons.person, size: 40, color: ChickiesColor.black.withOpacity(0.3))),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //* Setting button
                            RoundedContainer(
                              child: IntrinsicWidth(child: IconButton(onPressed: () {}, icon: Icon(Icons.settings))),
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(10),
                            ),
                            //* logout button
                            RoundedContainer(
                              child: IntrinsicWidth(
                                  child: IconButton(
                                      onPressed: () {
                                        SharedPrefs.clear();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                          (route) => false,
                                        );
                                      },
                                      icon: Icon(Icons.exit_to_app))),
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(10),
                            ),
                          ],
                        ),
                      ),
                      Text(username, style: TextStyle(fontSize: 25, color: ChickiesColor.black), overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.left),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            RoundedContainer(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(""),
            ),
            RoundedContainer(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}
