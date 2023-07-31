import 'package:bbti/bottom_nav_bar.dart';
import 'package:bbti/views/connecttolock.dart';
import 'package:bbti/views/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BBT Installation',
      theme: ThemeData(
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyNavigationBar(),
    );
  }
}
