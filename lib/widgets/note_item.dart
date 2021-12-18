import 'package:flutter/material.dart';
import 'package:flutter_notes/icons/pin_icons_icons.dart';

class NoteLayout extends StatelessWidget {
  final String note;
  final String title;

  NoteLayout({@required this.note, @required this.title});

  @override
  Widget build(BuildContext context) {
    return GridTile(
        header: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                PinIcons.pin_outline,
                color: Colors.white,
              ),
            )),
        footer: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: GridTileBar(
            backgroundColor: Colors.black,
            title: Text(title),
          ),
        ),
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                border: Border.all(color: Colors.black, width: 4),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(note)));
  }
}
