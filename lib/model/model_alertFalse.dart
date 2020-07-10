import 'package:flutter/material.dart';

class AlertFalse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Center(child: Text('Not Enough Money')),
      content: Center(
        heightFactor: 1.5,
        child: Container(
          child:
              Text('There\'s no enough money? \ntry to input your Cash first.'),
        ),
      ),
      contentTextStyle:
          TextStyle(fontSize: 16.0, letterSpacing: 0.5, color: Colors.black87),
    );
  }
}
