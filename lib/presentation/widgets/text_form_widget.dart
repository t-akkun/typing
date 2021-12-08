import 'package:flutter/material.dart';

import '../../constants.dart';

class TypingFormWidget extends StatelessWidget {
  final TextEditingController controller;
  TypingFormWidget({
    required this.controller,
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
        validator: (value) {
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length));
          return null;
        },
      ),
    );
  }
}
