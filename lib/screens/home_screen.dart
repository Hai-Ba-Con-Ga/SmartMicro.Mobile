import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chickies_ui/chickies_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: ChickiesColor.background,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/chickies_logo.png',
          height: 80,
        ),
        excludeHeaderSemantics: false,
        toolbarHeight: 90,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: ChickiesColor.primary,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5,
            top: -MediaQuery.of(context).size.height * 0.5,
            left: -MediaQuery.of(context).size.height * 0.5,
            right: -MediaQuery.of(context).size.height * 0.5,
            child: ClipOval(
              child: Container(
                  // height: MediaQuery.of(context).size.height * 0.5 * 2,
                  // width: MediaQuery.of(context).size.width * 1 * 2,
                  decoration: BoxDecoration(
                color: ChickiesColor.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              )),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 2,
            height: MediaQuery.of(context).size.height * 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 150),
                  //*body from here
                  RoundedContainer(child: Center(child: Text("123"),), height: 80),
                  RoundedContainer(child: Center(child: Text("123"),), height: 80),
                  RoundedContainer(child: Center(child: Text("123"),), height: 80),
                  RoundedContainer(child: Center(child: Text("123"),), height: 80),
                  RoundedContainer(child: Center(child: Text("123"),), height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
