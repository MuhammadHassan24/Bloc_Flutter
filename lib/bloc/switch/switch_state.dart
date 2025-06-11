import 'package:equatable/equatable.dart';

class SwitchState extends Equatable {
  final bool isEnabled;
  final double slider;

  const SwitchState({this.isEnabled = false, this.slider = 0});

  SwitchState copyWith({bool? isEnabled, double? slider}) {
    return SwitchState(
      isEnabled: isEnabled ?? this.isEnabled,
      slider: slider ?? this.slider,
    );
  }

  @override
  List<Object> get props => [isEnabled, slider];
}
