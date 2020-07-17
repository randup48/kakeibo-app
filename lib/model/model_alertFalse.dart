import 'package:flutter/material.dart';

class AlertFalse extends StatelessWidget {
  AlertFalse(this.alert);

  final String alert;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Center(child: Text('Not Enough Money')),
      content: Center(
        heightFactor: 1.5,
        child: Container(
          child: Text(
            alert,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      contentTextStyle:
          TextStyle(fontSize: 16.0, letterSpacing: 0.5, color: Colors.black87),
    );
  }
}
