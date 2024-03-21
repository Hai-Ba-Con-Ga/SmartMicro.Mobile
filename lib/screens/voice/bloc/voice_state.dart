part of 'voice_bloc.dart';

sealed class VoiceState {
  String message;
  bool isStart;
  VoiceState({this.message = "", this.isStart = false});
}

final class VoiceInitial extends VoiceState {
  VoiceInitial({required super.message});
}

final class VoiceMessage extends VoiceState {
  VoiceMessage({required super.message});
}
