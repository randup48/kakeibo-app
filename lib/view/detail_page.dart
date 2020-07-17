import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/constant.dart';
import 'package:kakeibo/model/model_transactionDetail.dart';

class DetailPage extends StatelessWidget {
  DetailPage({@required this.thisCategory});

  final Map<String, dynamic> thisCategory;

  @override
  Widget build(BuildContext context) {
    List data = thisCategory['data'];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kPaddingPage.copyWith(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  thisCategory['category'],
                  style: kHeaderTextStyle.copyWith(fontSize: 34.0),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => TransactionDetail(
                    category: data[data.length - 1 - index]['content'],
                    amount: data[data.length - 1 - index]['amount'],
                    leading: Text(DateFormat('EEEE,\ndd/MM\n/y.')
                        .format(data[data.length - 1 - index]['date'])),
                  ),
                  itemCount: data.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
