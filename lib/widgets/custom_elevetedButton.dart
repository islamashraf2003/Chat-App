import 'package:flutter/material.dart';

class customElevetedButton extends StatelessWidget {
  VoidCallback? onPressed;

  customElevetedButton({this.onPressed, required this.textName});
  String? textName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff323232),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          fixedSize: Size(200, 65),
        ),
        onPressed: onPressed,
        child: Text(
          '$textName',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
//Sign Up
