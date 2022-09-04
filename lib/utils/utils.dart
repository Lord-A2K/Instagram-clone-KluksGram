import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kluksgram/providers/nav_provider.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:provider/provider.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('no image selected!');
}

showSnackbar(String content, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors().accent,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      elevation: 20,
      duration: const Duration(seconds: 2),
      content: Text(
        content,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
    ),
  );
}
