import 'package:flutter/material.dart';
import 'package:flutter_notes/model/note.dart';
import 'package:flutter_notes/providers/notes_provider.dart';
import 'package:flutter_notes/widgets/note_item.dart';
import 'package:provider/provider.dart';

class GridLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, _) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemCount: notesProvider.getAllNotes().length,
          itemBuilder: (ctx, index) => NoteLayout(
                id: notesProvider.getAllNotes()[index].id,
                ctx: context,
              )),
    );
  }
}
