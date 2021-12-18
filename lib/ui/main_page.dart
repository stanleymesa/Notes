import 'package:flutter/material.dart';
import 'package:flutter_notes/model/note.dart';
import 'package:flutter_notes/ui/layout.dart';
import 'package:flutter_notes/widgets/grid.dart';
import 'package:intl/intl.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutPage(
        Padding(padding: const EdgeInsets.all(10), child: GridLayout()));
  }
}
