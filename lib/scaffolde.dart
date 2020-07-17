import 'package:flutter/material.dart';
import 'package:kakeibo/constant.dart';
import 'package:kakeibo/view/add_page.dart';
import 'package:kakeibo/view/note_page.dart';
import 'package:kakeibo/view/stats_page.dart';
import 'package:provider/provider.dart';
import 'controller/balance_class.dart';

class Scaffolde extends StatefulWidget {
  @override
  _ScaffoldeState createState() => _ScaffoldeState();
}

class _ScaffoldeState extends State<Scaffolde> {
  int _selectedIndex = 0;

  final _pageController = PageController();

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(_selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      body: ChangeNotifierProvider<Balance>(
        create: (context) => Balance(),
        child: PageView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            NotePage(_pageController),
            AddPage(_pageController),
            StatsPage(),
          ],
          onPageChanged: (page) {
            setState(() {
              _selectedIndex = page;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(Icons.account_balance),
            ),
            title: kLabel,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(Icons.receipt),
            ),
            title: kLabel,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(Icons.pie_chart),
            ),
            title: kLabel,
          )
        ],
      ),
    );
  }
}
