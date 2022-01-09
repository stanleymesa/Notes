import 'package:flutter/material.dart';
import 'package:flutter_notes/model/note.dart';
import 'package:flutter_notes/providers/notes_provider.dart';
import 'package:flutter_notes/ui/add_or_detail_page.dart';
import 'package:flutter_notes/ui/layout.dart';
import 'package:flutter_notes/widgets/grid.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutPage(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
                future: Provider.of<NotesProvider>(context, listen: false)
                    .getAndSetNotes(),
                builder: (context, snapshot) =>
                    (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridLayout())),
        fab: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            Navigator.of(context).pushNamed('/addOrDetailPage');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ));
  }
}
