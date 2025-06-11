import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraCapture extends ImagePickerEvent {}

class GalleryPicker extends ImagePickerEvent {}
