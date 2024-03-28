import 'package:SmartMicro.Mobile/screens/voice/bloc/voice_bloc.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Container/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Widget'),
      ),
      body: Container(
        child: BlocConsumer<VoiceBloc, VoiceState>(
          listenWhen: (previous, current) => current.message != previous.message && current.message.isNotEmpty && current.message.characters.last == '#',
          listener: (context, state) {
            BlocProvider.of<VoiceBloc>(context).add(UpdateMessage("Call Successful"));
          },
          builder: (context, state) {
          return RoundedContainer(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(state.message, style: TextStyle(color: ChickiesColor.primary, decoration: TextDecoration.none, fontSize: 20)),
          );
        }),
      ),
    );
  }

  BlocListener<VoiceBloc, VoiceState> _callByVoice() {
    return BlocListener<VoiceBloc, VoiceState>(
        listenWhen: (previous, current) => current.message != previous.message && current.message.isNotEmpty && current.message.characters.last == '#',
        listener: (context, state) {
          BlocProvider.of<VoiceBloc>(context).add(UpdateMessage("Call Successful"));
        }
        );
  }
}
