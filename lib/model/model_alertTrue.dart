import 'package:flutter/material.dart';

class AlertTrue extends StatelessWidget {
  AlertTrue({this.onPressed, this.title});

  final Function onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
      contentPadding: EdgeInsets.all(24.0),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            onPressed: onPressed,
            child: Text('YES', style: TextStyle(color: Colors.white,letterSpacing: 1.25)),
            color: Colors.orange[300],
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'NOPE',
              style: TextStyle(color: Colors.orange[300],letterSpacing: 1.25),
            ),
          )
        ],
      ),
    );
  }
}
