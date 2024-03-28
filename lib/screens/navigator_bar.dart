import 'package:SmartMicro.Mobile/BLE/iot_screen.dart';
import 'package:SmartMicro.Mobile/BLE/screens/scan_screen.dart';
import 'package:SmartMicro.Mobile/screens/chart_screen.dart';
import 'package:SmartMicro.Mobile/screens/home_screen.dart';
import 'package:SmartMicro.Mobile/screens/user_screen.dart';
import 'package:SmartMicro.Mobile/screens/voice/test_speech_to_text_screen.dart';
import 'package:SmartMicro.Mobile/screens/voice/test_widget.dart';
import 'package:SmartMicro.Mobile/screens/voice/voice_widget.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/chickies_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'voice/bloc/voice_bloc.dart';

class NavigatorBar extends StatefulWidget {
  
  const NavigatorBar({super.key});
  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  Color get appbarColor => ChickiesColor.purple;
  Color get backgroundColor => ChickiesColor.grey;
  int _selectedIndex = 0;
  late PageController _pageController;

  bool isOpenVoice = false;

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
    return BlocProvider(
      create: (context) => VoiceBloc()..add(UpdateMessage("Tap the microphone to start listening...")),
      child: Stack(
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
                IotScreen(),
                // ScanScreen(),
                // ChartScreen(),
                Navigator(
                  onGenerateRoute: (settings) {
                    Widget page1 = ChartScreen();
                    if (settings.name == 'test_widget') {
                      return MaterialPageRoute(builder: (context) => TestWidget());
                    }
                      return MaterialPageRoute(builder: (context) => page1);
                  },
                ),
                 UserScreen(),
                // TestSpeechToTextScreen(),
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
          //* Button Voice
          Positioned(
              child: DotButton(onPressed: () {
                setState(() {
                  isOpenVoice = !isOpenVoice;
                });
              }),
              left: MediaQuery.of(context).size.width / 5 * 4,
              bottom: 20),
          VoiceWidget(isOpenVoice: isOpenVoice),
        ],
      ),
    );
  }

  Widget AppBarButton({required int index, required Icon icon}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        color: Colors.transparent,
        // width: 60,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon.icon,
              color: _selectedIndex == index ? ChickiesColor.textPrimary : ChickiesColor.textPrimary.withOpacity(0.3),
            ),
            _selectedIndex == index ? Icon(Icons.circle, size: 5) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class DotButton extends StatelessWidget {
  const DotButton({
    super.key,
    required this.onPressed,
    this.child,
    this.color,
  });

  final VoidCallback onPressed;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: (color ?? ChickiesColor.primary).withOpacity(0.2), spreadRadius: 2, blurRadius: 10, offset: Offset(0, 10))],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        child: child ?? Icon(Icons.multitrack_audio, color: Colors.white, size: 30),
        backgroundColor: color ?? ChickiesColor.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(25),
        )),
      ),
    );
  }
}
