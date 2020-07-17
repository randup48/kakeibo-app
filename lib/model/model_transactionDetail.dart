import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/constant.dart';

class TransactionDetail extends StatelessWidget {
  TransactionDetail({this.category, this.amount, this.onTap, this.leading});

  final String category;
  final int amount;
  final Function onTap;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration:
            kboxDecoration.copyWith(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          leading: leading,
          title: Text(
            category,
            style: kHeadline.copyWith(color: Colors.black45),
          ),
          trailing: Text(
            'IDR ${NumberFormat('###,###').format(amount)}',
            style: kHeadline,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
