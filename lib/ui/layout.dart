import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  Widget body;
  Widget fab = Container();

  LayoutPage({this.body, this.fab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
      ),
      body: body,
      floatingActionButton: fab,
    );
  }
}
