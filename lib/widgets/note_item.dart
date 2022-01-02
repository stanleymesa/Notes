import 'package:flutter/material.dart';
import 'package:flutter_notes/icons/pin_icons_icons.dart';
import 'package:flutter_notes/model/note.dart';
import 'package:flutter_notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class NoteLayout extends StatelessWidget {
  final String id;

  NoteLayout({@required this.id});

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    Note _note = notesProvider.getNote(id);

    return Dismissible(
      key: Key(_note.id),
      onDismissed: (direction) => notesProvider.deleteNote(_note.id),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed('/addOrDetailPage', arguments: _note.id),
        child: GridTile(
            header: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    _note.isPinned ? PinIcons.pin : PinIcons.pin_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    notesProvider.isTogglePinnedCallback(id);
                  },
                )),
            footer: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: GridTileBar(
                backgroundColor: Colors.black,
                title: Text(_note.title),
              ),
            ),
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    border: Border.all(color: Colors.black, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(_note.note))),
      ),
    );
  }
}
