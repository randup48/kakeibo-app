import 'package:flutter/material.dart';
import 'package:kakeibo/constant.dart';

import 'model_Button.dart';

class AddFeature extends StatelessWidget {
  AddFeature({this.title, this.onPressed, this.children});

  final String title;
  final Function onPressed;
  final Widget children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: kHeadline.copyWith(color: Colors.black87),
          ),
          children,
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ButtonTheme(
              height: 48.0,
              child: Button(onPressed: onPressed),
            ),
          )
        ],
      ),
    );
  }
}


