import 'package:flutter/material.dart';

import '../../constants.dart';

class TypingFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function onPressEnter;
  TypingFormWidget({
    required this.controller,
    required this.onPressEnter,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.typingForm,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.always,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (value) {
          onPressEnter();
        },
        validator: (value) {
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length));
          return null;
        },
      ),
    );
  }
}
