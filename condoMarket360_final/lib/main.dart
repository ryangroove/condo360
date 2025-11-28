import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/home_page.dart';
import 'screens/cart_page.dart';
import 'screens/history_page.dart';
import 'screens/stock_page.dart';

void main() {
  runApp(CondoMarketApp());
}

class CondoMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CondoMarket 360°',


      theme: buildAppTheme(),

      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
        '/cart': (context) => CartPage(),
        '/history': (context) => HistoryPage(),
        '/stock': (context) => StockPage(),
      },
    );
  }
}