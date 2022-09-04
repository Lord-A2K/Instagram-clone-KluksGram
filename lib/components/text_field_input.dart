import 'package:flutter/material.dart';
import 'package:kluksgram/utils/appcolors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final bool multiline;
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      this.isPass = false,
      required this.textInputType,
      this.multiline = false});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      minLines: multiline ? 3 : 1,
      maxLines: multiline ? 3 : 1,
      controller: textEditingController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white38),
          border: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          fillColor: AppColors().secondary,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
