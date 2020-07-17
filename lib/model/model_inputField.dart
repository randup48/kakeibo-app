import 'package:flutter/material.dart';
import 'package:kakeibo/constant.dart';

class InputField extends StatelessWidget {
  InputField(
      {this.label,
      this.prefix,
      this.typeKeyboard,
      this.hint,
      this.controller,
      this.onPressed,
      this.validator});

  final String label;
  final Widget prefix;
  final String hint;
  final TextInputType typeKeyboard;
  final TextEditingController controller;
  final Function onPressed;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0),
      child: TextFormField(
        validator: validator,
        style: kValueCard,
        controller: controller,
        keyboardType: typeKeyboard,
        decoration: InputDecoration(
          labelStyle: kHeadline,
          contentPadding: EdgeInsets.all(24.0),
          prefix: prefix,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black45),
          labelText: label,
          fillColor: Colors.grey[100],
          filled: true,
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0),
              borderRadius: BorderRadius.circular(10.0)),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black87,
            ),
            padding: EdgeInsets.all(16.0),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
