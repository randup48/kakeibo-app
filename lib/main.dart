import 'package:flutter/material.dart';
import 'package:kakeibo/view/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange[300]),
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}
