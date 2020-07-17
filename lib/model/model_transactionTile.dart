import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/constant.dart';

class TransactionTile extends StatelessWidget {
  TransactionTile({this.category, this.amount, this.onTap, this.leading});

  final String category;
  final int amount;
  final Function onTap;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration:
            kboxDecoration.copyWith(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          subtitle: Text(
            'Detail',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          leading: leading,
          title: Text(
            category,
            style: kHeadline.copyWith(color: Colors.black45),
          ),
          trailing: Text(
            'Rp. ${NumberFormat('###,###').format(amount)}',
            style: kHeadline,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
