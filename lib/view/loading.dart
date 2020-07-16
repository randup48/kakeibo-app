import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:kakeibo/scaffolde.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffolde(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FlareActor("assets/kakeibo.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "kakeibo"),
    );
  }
}
