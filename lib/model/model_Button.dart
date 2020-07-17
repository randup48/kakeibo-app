import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Colors.orange[300],
      onPressed: onPressed,
      icon: Icon(
        Icons.create,
        size: 16.0,
        color: Colors.white,
      ),
      label: Text(
        'WRITE THAT',
        style: TextStyle(
            letterSpacing: 1.25,
            color: Colors.white,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
