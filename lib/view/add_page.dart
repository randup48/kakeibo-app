import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kakeibo/constant.dart';
import 'package:kakeibo/controller/balance_class.dart';
import 'package:kakeibo/model/model_Button.dart';
import 'package:kakeibo/model/model_alertFalse.dart';
import 'package:kakeibo/model/model_alertTrue.dart';
import 'package:kakeibo/model/model_inputField.dart';

class AddPage extends StatefulWidget {
  AddPage(this.pageController);
  final PageController pageController;
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final amountController = TextEditingController();
  final contentController = TextEditingController();

  String dropdownInput;
  String amountInput;
  String contentInput;

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    contentController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dailyExpenses = Provider.of<Balance>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250.0,
            color: Colors.grey[100],
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: kPaddingPage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Expense \nReceipt',
                      style: kHeaderTextStyle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 34.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.grey[50],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: -14.0,
                              blurRadius: 34.0,
                              offset: Offset(0.0, 8.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 34.0, horizontal: 24.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  validator: (category) => category == null
                                      ? 'You haven\'t input anything yet'
                                      : null,
                                  elevation: 4,
                                  style: kValueCard,
                                  items: dailyExpenses.category
                                      .map((category) => DropdownMenuItem(
                                            child: Text(category),
                                            value: category,
                                          ))
                                      .toList(),
                                  onChanged: (category) {
                                    setState(() {
                                      dropdownInput = category;
                                    });
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(24.0),
                                    labelText: 'Category',
                                    labelStyle: kHeadline,
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0),
                                    ),
                                  ),
                                ),
                                InputField(
                                  validator: (value) => value.isEmpty
                                      ? 'You haven\'t input anything yet'
                                      : null,
                                  controller: amountController,
                                  prefix: Padding(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child: Text('Rp.'),
                                  ),
                                  label: 'Amount',
                                  typeKeyboard: TextInputType.numberWithOptions(
                                      decimal: true),
                                  onChanged: (input) {
                                    amountInput = input;
                                  },
                                  onPressed: () {
                                    amountController.clear();
                                  },
                                ),
                                InputField(
                                  validator: (value) => value.isEmpty
                                      ? 'You haven\'t input anything yet'
                                      : null,
                                  controller: contentController,
                                  label: 'Content',
                                  hint: 'What did you spend?',
                                  onChanged: (input) {
                                    contentInput = input;
                                  },
                                  onPressed: () {
                                    contentController.clear();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 48.0),
                      child: ButtonTheme(
                        height: 48.0,
                        child: Button(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (dailyExpenses.cash >=
                                  int.parse(amountController.text)) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertTrue(
                                    title:
                                        'Are You Sure \nWant to Submit This Receipt?',
                                    onPressed: () {
                                      dailyExpenses.addTransaction(
                                          dropdownInput,
                                          amountInput,
                                          contentInput,
                                          DateTime.now());
                                      _formKey.currentState.reset();
                                      Navigator.pop(context);
                                      widget.pageController.jumpToPage(2);
                                    },
                                  ),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertFalse());
                                _formKey.currentState.reset();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
