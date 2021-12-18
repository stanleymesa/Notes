import 'package:flutter/material.dart';
import 'package:flutter_notes/ui/layout.dart';
import 'package:flutter_notes/ui/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainPage(),
    );
  }
}
