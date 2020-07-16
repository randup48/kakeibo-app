import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/model/model_Button.dart';
import 'package:kakeibo/model/model_inputField.dart';
import 'package:kakeibo/view/tips_page.dart';
import 'package:provider/provider.dart';
import 'package:kakeibo/constant.dart';
import 'package:kakeibo/controller/balance_class.dart';
import 'package:kakeibo/model/model_addButton.dart';
import 'package:kakeibo/model/model_addFeature.dart';
import 'package:kakeibo/model/model_alertFalse.dart';
import 'package:kakeibo/model/model_alertTrue.dart';
import 'package:kakeibo/model/model_card.dart';

class NotePage extends StatefulWidget {
  NotePage(this.pageController);
  final PageController pageController;
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final cashController = TextEditingController();
  final savingsController = TextEditingController();
  final takensavingsController = TextEditingController();
  final contenttakensavingsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cashController.dispose();
    savingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balance = Provider.of<Balance>(context, listen: false);
    return Stack(
      children: [
        Container(
          height: 225.0,
          width: double.infinity,
          color: Colors.blue[300],
        ),
        SafeArea(
          child: Padding(
            padding: kPaddingPage.copyWith(bottom: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 17.0),
                      child: Text(
                        'Balance',
                        style: kHeaderTextStyle.copyWith(color: Colors.white),
                      ),
                    ),
                    Cards(
                      inputedValue: Consumer<Balance>(
                          builder: (_, cashObject, __) => Text(
                                'Rp. ${NumberFormat('###,###').format(cashObject.cash)}',
                                style: kValueCardBig.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40),
                              )),
                      icon: Icons.account_balance_wallet,
                      title: 'Cash',
                      trailing: AddButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: AddFeature(
                                  children: Form(
                                      key: _formKey,
                                      child: InputField(
                                        controller: cashController,
                                        prefix: Padding(
                                          padding:
                                              EdgeInsets.only(right: 16.0),
                                          child: Text('Rp.'),
                                        ),
                                        typeKeyboard:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        label: 'Amount',
                                        validator: (value) => value.isEmpty
                                            ? 'You haven\'t input anything yet'
                                            : null,
                                        onPressed: () {
                                          cashController.clear();
                                        },
                                      )),
                                  title: 'Add Cash',
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertTrue(
                                          title:
                                              'Are You Sure Want to \nAdd Your Cash?',
                                          children: Text(
                                              'This is the money you have'),
                                          onPressed: () {
                                            balance
                                                .addCash(cashController.text);
                                            Navigator.pop(context);
                                            cashController.clear();
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Cards(
                      inputedValue: Consumer<Balance>(
                          builder: (_, savingsObject, __) => Text(
                                'Rp. ${NumberFormat('###,###').format(savingsObject.savings)}',
                                style: kValueCardBig.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green[300],
                                    fontSize: 40),
                              )),
                      icon: Icons.monetization_on,
                      title: 'Savings',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //minus
                          Container(
                            height: 34.0,
                            width: 38.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange[300]),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                Icons.remove,
                                size: 20.0,
                              ),
                              color: Colors.orange[300],
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 48.0, vertical: 24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Savings Taken',
                                              textAlign: TextAlign.center,
                                              style: kHeadline.copyWith(
                                                  color: Colors.black87),
                                            ),
                                            Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  InputField(
                                                    controller:
                                                        takensavingsController,
                                                    label: 'Amount',
                                                    prefix: Padding(
                                                      padding:
                                                          EdgeInsets.only(
                                                              right: 16.0),
                                                      child: Text('Rp.'),
                                                    ),
                                                    typeKeyboard: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    validator: (value) => value
                                                            .isEmpty
                                                        ? 'You haven\'t input anything yet'
                                                        : null,
                                                    onPressed: () {
                                                      takensavingsController
                                                          .clear();
                                                    },
                                                  ),
                                                  InputField(
                                                    controller:
                                                        contenttakensavingsController,
                                                    hint:
                                                        'Why you take this savings?',
                                                    label: 'Content',
                                                    onPressed: () {
                                                      contenttakensavingsController
                                                          .clear();
                                                    },
                                                    validator: (value) => value
                                                            .isEmpty
                                                        ? 'You haven\'t input anything yet'
                                                        : null,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20),
                                              child: ButtonTheme(
                                                height: 48,
                                                child: Button(
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      if (balance.savings >=
                                                          int.parse(
                                                              takensavingsController
                                                                  .text)) {
                                                        Navigator.pop(
                                                            context);
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  AlertTrue(
                                                            title:
                                                                'Are You Sure Want to \nUse Your Savings?',
                                                            children: Text(
                                                                'This is the savings you used'),
                                                            onPressed: () {
                                                              balance.takenSavings(
                                                                  takensavingsController
                                                                      .text,
                                                                  DateTime
                                                                      .now(),
                                                                  contenttakensavingsController
                                                                      .text);
                                                              takensavingsController
                                                                  .clear();
                                                              contenttakensavingsController
                                                                  .clear();
                                                              Navigator.pop(
                                                                  context);
                                                              widget
                                                                  .pageController
                                                                  .jumpToPage(
                                                                      2);
                                                            },
                                                          ),
                                                        );
                                                      } else {
                                                        Navigator.pop(
                                                            context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertFalse(
                                                                  'There\'s no enough \nsavings to use'),
                                                        );
                                                        _formKey.currentState
                                                            .reset();
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          //plus
                          Container(
                            height: 34.0,
                            width: 38.0,
                            decoration: BoxDecoration(
                                color: Colors.orange[300],
                                borderRadius: BorderRadius.circular(5.0)),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                Icons.add,
                                size: 20,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: AddFeature(
                                        children: Form(
                                          key: _formKey,
                                          child: InputField(
                                            controller: savingsController,
                                            label: 'Amount',
                                            prefix: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 16.0),
                                              child: Text('Rp.'),
                                            ),
                                            typeKeyboard: TextInputType
                                                .numberWithOptions(
                                                    decimal: true),
                                            onPressed: () {
                                              savingsController.clear();
                                            },
                                            validator: (value) => value
                                                    .isEmpty
                                                ? 'You haven\'t input anything yet'
                                                : null,
                                          ),
                                        ),
                                        title: 'Add Savings',
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            if (balance.cash >=
                                                int.parse(
                                                    savingsController.text)) {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertTrue(
                                                        title:
                                                            'Are You Sure Want to \nSaving Your Money?',
                                                        onPressed: () {
                                                          balance.addSavings(
                                                              savingsController
                                                                  .text,
                                                              DateTime.now());
                                                          savingsController
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
                                                          widget
                                                              .pageController
                                                              .jumpToPage(2);
                                                        },
                                                      ));
                                            } else {
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertFalse(
                                                    'there\'s no enough money, \ntry to input your cash first'),
                                              );
                                              savingsController.clear();
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                OutlineButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TipsPage()));
                  },
                  icon: Icon(Icons.wb_incandescent,color: Colors.orange[300],),
                  label: Text(
                    'Tips'.toUpperCase(),
                    style: TextStyle(letterSpacing: 1.25,color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
