import 'package:flutter/material.dart';

snackBar(
    {required String title, required Color bgColor, required Color textColor}) {
  return SnackBar(
    content: Text(
      title,
      style: TextStyle(color: textColor),
    ),
    backgroundColor: bgColor,
  );
}
