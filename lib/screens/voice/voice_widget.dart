import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:SmartMicro.Mobile/screens/voice/bloc/voice_bloc.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/chickies_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoiceWidget extends StatelessWidget {
  const VoiceWidget({
    super.key,
    required this.isOpenVoice,
  });

  final bool isOpenVoice;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: isOpenVoice
          ? Container(
            color: Colors.transparent,
            height: 250,
            child: Stack(
              alignment: Alignment.topCenter,
                children: [
                  RoundedContainer(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: BlocBuilder<VoiceBloc, VoiceState>(
                      builder: (context, state) {
                        return Center(
                            child: Text(state.message,
                                style: TextStyle(
                                  color: ChickiesColor.primary,
                                  decoration: TextDecoration.none,
                                  fontSize: 20,
                                )));
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: ChickiesDotButton( child: 
                    Icon(Icons.mic_sharp, color: Colors.white, size: 25)
                     ,onPressed: () {
                      context.read<VoiceBloc>().add(UpdateMessage("init"));
                    }),
                  )
                ],
              ),
          )
          : SizedBox.shrink(),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final inAnimation = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0)).animate(animation);
        final outAnimation = Tween<Offset>(begin: Offset(0, -1.0), end: Offset(0.0, 0.0)).animate(animation);
        if (child.key == ValueKey(0)) {
          return ClipRect(child: SlideTransition(position: inAnimation, child: Padding(padding: const EdgeInsets.all(8.0), child: child)));
        } else {
          return ClipRect(child: SlideTransition(position: outAnimation, child: Padding(padding: const EdgeInsets.all(8.0), child: child)));
        }
      },
    );
  }
}
