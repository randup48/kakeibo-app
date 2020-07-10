import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:kakeibo/constant.dart';
import 'package:kakeibo/controller/balance_class.dart';
import 'package:kakeibo/main.dart';
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
          height: 250.0,
          width: double.infinity,
          color: Colors.blue[300],
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: kPaddingPage,
              child: Column(
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
                                  fontWeight: FontWeight.w600),
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
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddFeature(
                                children: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(16.0),
                                      prefix: Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Text('Rp.'),
                                      ),
                                      suffixIcon: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.black87,
                                          ),
                                          onPressed: () {
                                            cashController.clear();
                                          }),
                                      border: OutlineInputBorder(),
                                    ),
                                    style: kValueCard,
                                    autofocus: true,
                                    controller: cashController,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    validator: (value) => value.isEmpty
                                        ? 'You haven\'t input anything yet'
                                        : null,
                                  ),
                                ),
                                title: 'Add Cash',
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertTrue(
                                        title:
                                            'Are You Sure Want To \nAdd Your ${cashController.text} Cash?',
                                        onPressed: () {
                                          Navigator.pop(context);
                                          balance.addCash(cashController.text);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyApp()));
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
                        builder: (_, expensesObject, __) => Text(
                              'Rp. ${NumberFormat('###,###').format(expensesObject.expenses)}',
                              style: kValueCardBig.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red[300]),
                            )),
                    icon: Icons.money_off,
                    title: 'Expenses',
                  ),
                  Cards(
                    inputedValue: Consumer<Balance>(
                        builder: (_, savingsObject, __) => Text(
                              'Rp. ${NumberFormat('###,###').format(savingsObject.savings)}',
                              style: kValueCardBig.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[300]),
                            )),
                    icon: Icons.monetization_on,
                    title: 'Savings',
                    trailing: AddButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddFeature(
                                children: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(16.0),
                                      prefix: Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Text('Rp.'),
                                      ),
                                      suffixIcon: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.black87,
                                          ),
                                          onPressed: () {
                                            savingsController.clear();
                                          }),
                                      border: OutlineInputBorder(),
                                    ),
                                    style: kValueCard,
                                    controller: savingsController,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    validator: (value) => value.isEmpty
                                        ? 'You haven\'t input anything yet'
                                        : null,
                                  ),
                                ),
                                title: 'Add Savings',
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    if (balance.cash >=
                                        int.parse(savingsController.text)) {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertTrue(
                                                title:
                                                    'Are You Sure Want to \nSaving Your ${savingsController.text} Money?',
                                                onPressed: () {
                                                  balance.addSavings(
                                                      savingsController.text,
                                                      DateTime.now());
                                                  savingsController.clear();
                                                  Navigator.pop(context);
                                                  widget.pageController
                                                      .jumpToPage(2);
                                                },
                                              ));
                                    } else {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertFalse(),
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
                  ),
                  SizedBox(height: 250)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
