import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'voice_event.dart';
part 'voice_state.dart';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  VoiceBloc() : super(VoiceInitial(message: "init")) {
    on<UpdateMessage>((event, emit) {
      if (event.message == null || event.message.isEmpty) {
        emit(VoiceInitial(message: "stopped"));
      } 
      emit(VoiceMessage(message: event.message));
    });
  }
}
