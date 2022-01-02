import 'package:flutter/material.dart';
import 'package:flutter_notes/providers/notes_provider.dart';
import 'package:flutter_notes/ui/add_or_detail_page.dart';
import 'package:flutter_notes/ui/layout.dart';
import 'package:flutter_notes/ui/main_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: MainPage(),
          routes: {'/addOrDetailPage': (context) => AddOrDetailPage()}),
    );
  }
}
