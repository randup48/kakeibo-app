import 'package:flutter/material.dart';

class AlertTrue extends StatelessWidget {
  AlertTrue({this.onPressed, this.title, this.children});

  final Function onPressed;
  final String title;
  final Widget children;

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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(child: children),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: onPressed,
                  child: Text('YES',
                      style:
                          TextStyle(color: Colors.white, letterSpacing: 1.25)),
                  color: Colors.orange[300],
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'NOPE',
                    style: TextStyle(
                        color: Colors.orange[300], letterSpacing: 1.25),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
