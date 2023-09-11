import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Loader',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        hintColor: Color.fromARGB(255, 20, 39, 202), // 原用 accentColor 已爆红
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 22.0, color: Color.fromARGB(255, 113, 64, 204)),
          // headline1: TextStyle(  // headline1 headline2 已弃用
          displayMedium: TextStyle(
            // headline2: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 47, 44, 194),
          ),
          bodyLarge: TextStyle(
            // bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Colors.blueAccent,
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
