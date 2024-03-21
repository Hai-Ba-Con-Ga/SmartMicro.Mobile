import 'package:SmartMicro.Mobile/BLE/flutter_blue_app.dart';
import 'package:SmartMicro.Mobile/screens/home_screen.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorBar extends StatefulWidget {
  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  Color get appbarColor => ChickiesColor.purple;
  Color get backgroundColor => ChickiesColor.grey;
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // extendBodyBehindAppBar: true,
          // extendBody: true,
          backgroundColor: backgroundColor,
          //* BODY
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: <Widget>[
              HomeScreen(),
              FlutterBlueApp(),
              Container(color: ChickiesColor.background, child: Text('Home Page1')),
              // Container(color: appbarColor, child: Text('Home Page1')),
            ],
          ),
          //* Bottom Navigator App Bar
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            child: Container(
              height: 70,
              child: BottomAppBar(
                elevation: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    AppBarButton(index: 0, icon: const Icon(Icons.home)),
                    AppBarButton(index: 1, icon: const Icon(Icons.school)),
                    AppBarButton(index: 2, icon: const Icon(Icons.person)),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
        //* Button Add new...
        Positioned(
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: appbarColor.withOpacity(0.2), spreadRadius: 2, blurRadius: 10, offset: Offset(0, 10))],
              ),
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.multitrack_audio, color: Colors.white, size: 30),
                backgroundColor: appbarColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
              ),
            ),
            left: MediaQuery.of(context).size.width / 5 * 4,
            bottom: 20),
      ],
    );
  }

  Widget AppBarButton({required int index, required Icon icon}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        color: ChickiesColor.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon.icon,
              color: _selectedIndex == index ? ChickiesColor.textPrimary : ChickiesColor.textPrimary?.withOpacity(0.3),
            ),
            _selectedIndex == index ? Icon(Icons.circle, size: 5) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
