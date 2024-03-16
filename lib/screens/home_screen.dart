import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color get appbarColor => Color(0xFF7e7dd6);
  Color get backgroundColor => Color(0xFFeef2f9);
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
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: backgroundColor,
          //* APP BAR
          appBar: AppBar(
            title: Text('Home Screen', style: TextStyle(color: Colors.white)),
            backgroundColor: appbarColor,
          ),
          //* BODY
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: <Widget>[
              Container(color: backgroundColor, child: Text('Home Page1')),
              Container(color: backgroundColor, child: Text('Home Page1')),
              Container(color: appbarColor, child: Text('Home Page1')),
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
              decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.9), spreadRadius: 20, blurRadius: 40, offset: Offset(0, 2))]),
              child: BottomAppBar(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
            left: MediaQuery.of(context).size.width / 4 * 3,
            bottom: 20),
      ],
    );
  }

  Column AppBarButton({required int index, required Icon icon}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 25,
          child: IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: icon,
            onPressed: () => _onItemTapped(index),
          ),
        ),
        _selectedIndex == index ? Icon(Icons.circle, size: 5) : SizedBox.shrink(),
      ],
    );
  }
}
