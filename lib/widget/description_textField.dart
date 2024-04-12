import 'package:flutter/material.dart';
class descriptio_textField extends StatelessWidget {
  final TextEditingController description_Controller;
  const descriptio_textField({
    super.key,
    required this.description_Controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: description_Controller,
      minLines: 6,
      maxLines: 8,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: "Description",
      ),
    );
  }
}

class titleTextField extends StatelessWidget {
  final TextEditingController editing_controller;
  const titleTextField({
    super.key,
    required this.editing_controller,
  });

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: editing_controller,
      decoration: InputDecoration(
        hintText: "Ttile",
      ),
    );
  }
}
