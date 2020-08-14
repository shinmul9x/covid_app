import 'package:covid_app/screens/mainpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    ThemeData base = Theme.of(context);
    return MaterialApp(
      title: 'Covid-19',
      home: MainPage(),
      theme: base.copyWith(
        cardTheme: CardTheme(
          color: const Color(0xff333346),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        dividerColor: const Color(0xff585761),
        textTheme: base.textTheme.copyWith(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
