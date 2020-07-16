import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/model/model_alertTrue.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:kakeibo/constant.dart';
import 'package:kakeibo/controller/balance_class.dart';
import 'package:kakeibo/model/model_transactionTile.dart';

import 'detail_page.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final balance = Provider.of<Balance>(context);
    List thisMonth =
        balance.transaction.where((d) => d.date.month == now.month).toList();

    List thisCategory = thisMonth
        .fold(
          Map<String, List>(),
          (Map<String, List> a, b) {
            a.putIfAbsent(b.category, () => []).add(b);
            return a;
          },
        )
        .values
        .where((l) => l.isNotEmpty)
        .map(
          (l) => {
            'category': l.first.category,
            'data': l
                .map(
                  (e) => {
                    'amount': e.amount,
                    'content': e.content,
                    'date': e.date
                  },
                )
                .toList()
          },
        )
        .toList();

    List amountCategory = thisCategory
        .map(
          (entry) => {
            'category': entry['category'],
            'amount': (entry['data'] as List<Map<String, dynamic>>)
                .fold<int>(0, (prev, element) => prev + element['amount'])
          },
        )
        .toList();

    Map<String, double> dataMap = Map.fromIterable(amountCategory,
        key: (c) => c['category'], value: (c) => c['amount'].toDouble());

    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: 400.0,
          width: double.infinity,
        ),
        SafeArea(
          child: Padding(
            padding: kPaddingPage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monthly \nExpenses',
                      style: kHeaderTextStyle,
                    ),
                    OutlineButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertTrue(
                            title:
                                "Are You Sure Want to \nDelete All the Data?",
                            children: Text(
                                'Your cash and savings \nwill be erased',
                                textAlign: TextAlign.center),
                            onPressed: () {
                              balance.deleteAll();
                              setState(() {});
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.black87,
                      ),
                      label: Text(
                        'All'.toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 1.25, color: Colors.black87),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20.0,
                        ),
                        onPressed: () {
                          setState(() {
                            now = DateTime(now.year, now.month - 1, now.day);
                          });
                        },
                      ),
                      Text(
                        DateFormat.yMMMM().format(now),
                        style: kHeadline,
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.0,
                        ),
                        onPressed: () {
                          setState(() {
                            now = DateTime(now.year, now.month + 1, now.day);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                dataMap.isNotEmpty && dataMap != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: kboxDecoration.copyWith(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Overview',
                                      style: kHeadline.copyWith(
                                          color: Colors.black45),
                                    ),
                                  ),
                                  Container(
                                    height: 34.0,
                                    width: 48.0,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.grey[300]),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(Icons.delete_outline),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertTrue(
                                              title:
                                                  "Are You Sure Want to \nDelete This Month Data?",
                                              children: Text(
                                                'Your cash and savings \nwill not be erased',
                                                textAlign: TextAlign.center,
                                              ),
                                              onPressed: () {
                                                balance.deleteThisMonth(now);
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                              PieChart(
                                chartLegendSpacing: 60,
                                chartValueStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700),
                                legendStyle: TextStyle(
                                    fontSize: 14.0,
                                    letterSpacing: 0.25,
                                    fontWeight: FontWeight.w500),
                                dataMap: dataMap,
                                legendPosition: LegendPosition.left,
                                showChartValuesOutside: true,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '404',
                              style: kHeaderTextStyle,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'There\'s Nothing In Here'.toUpperCase(),
                              style: TextStyle(
                                  letterSpacing: 1.25,
                                  fontSize: 14.0,
                                  color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                dataMap.isNotEmpty && dataMap != null
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => TransactitonTile(
                            category: thisCategory[index]['category'],
                            amount: amountCategory[index]['amount'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      thisCategory: thisCategory[index]),
                                ),
                              );
                            },
                          ),
                          itemCount: thisCategory.length,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
