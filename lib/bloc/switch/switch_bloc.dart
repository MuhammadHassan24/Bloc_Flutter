import 'package:bloc_counter_app/bloc/switch/switch_event.dart';
import 'package:bloc_counter_app/bloc/switch/switch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchState()) {
    on<EnableAndDisableSwitch>(_isEnableOrDisableSwitch);
    on<SliderEvent>(_sliderEvent);
  }

  void _isEnableOrDisableSwitch(
    EnableAndDisableSwitch event,
    Emitter<SwitchState> emit,
  ) {
    emit(state.copyWith(isEnabled: !state.isEnabled));
  }

  void _sliderEvent(SliderEvent event, Emitter<SwitchState> emit) {
    emit(state.copyWith(slider: event.sliderValue));
  }
}
