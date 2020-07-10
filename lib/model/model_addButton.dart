import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  AddButton({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Colors.orange[300],
      label: Text('ADD',style: TextStyle(color: Colors.white,letterSpacing: 1.25),),
      icon: Icon(
        Icons.add,color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
