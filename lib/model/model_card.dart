import 'package:flutter/material.dart';
import 'package:kakeibo/constant.dart';

class Cards extends StatelessWidget {
  Cards({this.icon, this.title, this.trailing, this.inputValue});

  final String title;
  final IconData icon;
  final Widget trailing;
  final Widget inputValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 17.0),
      child: Container(
        decoration:
            kboxDecoration.copyWith(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 16.0, top: 8.0),
              leading: Icon(icon),
              title: Text(
                title,
                style: kHeadline.copyWith(color: Colors.black45),
              ),
              trailing: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0), child: trailing),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 34, 16, 16),
              child: inputValue,
            )
          ],
        ),
      ),
    );
  }
}
