import 'dart:async';

import 'package:SmartMicro.Mobile/api/client_chatgpt.dart';
import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:SmartMicro.Mobile/screens/voice/bloc/voice_bloc.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/chickies_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

class VoiceWidget extends StatefulWidget {
  const VoiceWidget({
    super.key,
    required this.isOpenVoice,
  });

  final bool isOpenVoice;

  @override
  State<VoiceWidget> createState() => _VoiceWidgetState();
}

class _VoiceWidgetState extends State<VoiceWidget> {
  TextToSpeech tts = TextToSpeech();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    print(_speechEnabled);
    setState(() {});
  }

  // /// Each time to start a speech recognition session
  // void _startListening

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _callChatGPT() async {
    context.read<VoiceBloc>().add(UpdateMessage('loading...'));
    final response = await APIClientChatGPT().fetchData(_lastWords);
    context.read<VoiceBloc>().add(UpdateMessage(response));
    await tts.speak(response);
  }

  int _counter = 0;
  void _startTimer() {
    setState(() {
      _counter = 5;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter >= 0) {
        _counter--;
      } else {
        setState(() {
          _counter = 0;
        });
        timer.cancel();
        _callChatGPT();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: widget.isOpenVoice
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
                    child: DotButton(
                      child: Icon(_speechToText.isNotListening ? Icons.mic_off_sharp : Icons.mic_sharp, color: Colors.white, size: 25),
                      onPressed:
                          // () {
                          //   context.read<VoiceBloc>().add(UpdateMessage("init"));
                          // }
                          // If not yet listening for speech start, otherwise stop
                          _speechToText.isNotListening
                              ? () async {
                                  _startTimer();
                                  await _speechToText.listen(
                                      onResult: (SpeechRecognitionResult result) {
                                        setState(() {
                                          _lastWords = result.recognizedWords;
                                        });
                                        context.read<VoiceBloc>().add(UpdateMessage(result.recognizedWords));
                                      },
                                      listenFor: Duration(
                                        seconds: 5,
                                      ));
                                  setState(
                                    () {},
                                  );
                                }
                              : _stopListening,
                    ),
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
