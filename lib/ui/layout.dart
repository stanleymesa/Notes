import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  Widget body;

  LayoutPage(this.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
      ),
      body: body,
    );
  }
}
