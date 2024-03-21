part of 'voice_bloc.dart';

@immutable
sealed class VoiceEvent {}

class UpdateMessage extends VoiceEvent {
  final String message;
  UpdateMessage(this.message);
}

class StartListening extends VoiceEvent {

}