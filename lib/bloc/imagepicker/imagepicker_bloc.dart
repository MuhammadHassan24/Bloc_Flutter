import 'package:bloc_counter_app/bloc/imagepicker/imagepicker_event.dart';
import 'package:bloc_counter_app/bloc/imagepicker/imagepicker_state.dart';
import 'package:bloc_counter_app/utils/image_picker_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc(this.imagePickerUtils) : super(ImagePickerState()) {
    on<CameraCapture>(cameraCapture);
    on<GalleryPicker>(galleryPicker);
  }

  cameraCapture(CameraCapture event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await imagePickerUtils.pickwithCamera();
    emit(state.copyWith(file: file));
  }

  galleryPicker(GalleryPicker event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await imagePickerUtils.pickwithGallery();
    emit(state.copyWith(file: file));
  }
}
