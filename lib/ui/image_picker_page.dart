import 'dart:io';

import 'package:bloc_counter_app/bloc/imagepicker/imagepicker_bloc.dart';
import 'package:bloc_counter_app/bloc/imagepicker/imagepicker_event.dart';
import 'package:bloc_counter_app/bloc/imagepicker/imagepicker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker')),
      body: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 230,
                    width: 280,
                    child:
                        state.file != null
                            ? Image.file(
                              File(state.file!.path.toString()),
                              fit: BoxFit.cover,
                            )
                            : Center(child: const Text('No image selected')),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ImagePickerBloc>().add(CameraCapture());
                    },
                    child: const Text('Capture Image'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ImagePickerBloc>().add(GalleryPicker());
                    },
                    child: const Text('Pick from Gallery'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
