import 'package:flutter/material.dart';

class CutomFormTextFiled extends StatelessWidget {
  String? hintText;
  Function(String)? onChanged;
  bool isObscure = false;
  CutomFormTextFiled(
      {this.hintText,
      this.onChanged,
      this.messageValidator,
      this.isObscure = false});
  String? Function(String?)? messageValidator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        obscureText: isObscure,
        validator: messageValidator,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
