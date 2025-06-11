import 'dart:developer';

import 'package:bloc_counter_app/bloc/switch/switch_bloc.dart';
import 'package:bloc_counter_app/bloc/switch/switch_event.dart';
import 'package:bloc_counter_app/bloc/switch/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchPage extends StatelessWidget {
  const SwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Switch Page")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen:
                      (previous, current) =>
                          previous.isEnabled != current.isEnabled,
                  builder: (context, state) {
                    log("Text Rebuilt");
                    return Text(
                      "Switch is: ${state.isEnabled ? "Enabled " : "Disabled"}",
                    );
                  },
                ),

                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen:
                      (previous, current) =>
                          previous.isEnabled != current.isEnabled,
                  builder: (context, state) {
                    log("IsEnable");
                    return Switch(
                      value: state.isEnabled,
                      onChanged: (value) {
                        context.read<SwitchBloc>().add(
                          EnableAndDisableSwitch(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen:
                  (previous, current) => previous.slider != current.slider,
              builder: (context, state) {
                log("container");
                return Container(
                  width: 280,
                  height: 150,
                  color: Colors.red.withValues(alpha: state.slider),
                );
              },
            ),
            SizedBox(height: 50),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen:
                  (previous, current) => previous.slider != current.slider,
              builder: (context, state) {
                log("slider");
                return Slider(
                  value: state.slider,
                  onChanged: (value) {
                    context.read<SwitchBloc>().add(
                      SliderEvent(sliderValue: value),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
