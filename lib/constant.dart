import 'package:flutter/material.dart';

const kHeaderTextStyle = TextStyle(
    fontSize: 40.0, fontWeight: FontWeight.w700, color: Colors.black87);

const kHeadline = TextStyle(
    fontSize: 20.0,
    color: Colors.black87,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w500);

const kValueCard = TextStyle(fontSize: 24.0, color: Colors.black87);

const kValueCardBig =
    TextStyle(fontSize: 34.0, color: Colors.black87, letterSpacing: 0.25);

const kPaddingPage = EdgeInsets.fromLTRB(34, 48, 34, 0);

const kboxDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      spreadRadius: -10.0,
      blurRadius: 34.0,
      offset: Offset(0.0, 8.0),
    ),
  ],
);
