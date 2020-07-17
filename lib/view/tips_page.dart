import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class TipsPage extends StatefulWidget {
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  final storyController = StoryController();

  List<StoryItem> tips = [
    StoryItem.text(
        title: 'Try to input Cash \nevery time you get money.',
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 15)),
    StoryItem.text(
        title: 'Try to input Savings \nevery time you input Cash.',
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 15)),
    StoryItem.text(
        title:
            'Do a Savings evaluation at the end of each month, \nby looking at Monthly Expenses.',
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 15)),
    StoryItem.text(
        title:
            'You can increase your Savings, \nby cutting unnecessary expenses \nfrom previous month.',
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 15)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        onVerticalSwipeComplete: (s) {
          Navigator.pop(context);
        },
        storyItems: tips,
        controller: storyController,
        onComplete: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
