import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required color, required message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$message'),
      backgroundColor: color,
    ),
  );
}
