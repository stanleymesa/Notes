import 'package:flutter/foundation.dart';
import 'package:flutter_notes/sqlite/database_helper.dart';

class Note {
  final String id, title, note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPinned;

  Note(
      {@required this.id,
      @required this.title,
      @required this.note,
      @required this.createdAt,
      @required this.updatedAt,
      @required this.isPinned});

  Note.kosong()
      : id = null,
        title = '',
        note = '',
        createdAt = null,
        updatedAt = null,
        isPinned = false;

  Note.fromDB(Map<String, dynamic> map)
      : id = map[DatabaseHelper.KEY_ID],
        title = map[DatabaseHelper.KEY_TITLE],
        note = map[DatabaseHelper.KEY_NOTE],
        isPinned = map[DatabaseHelper.KEY_ISPINNED] == 1,
        createdAt = DateTime.parse(map[DatabaseHelper.KEY_CREATED_AT]),
        updatedAt = DateTime.parse(map[DatabaseHelper.KEY_UPDATED_AT]);

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.KEY_ID: id,
      DatabaseHelper.KEY_TITLE: title,
      DatabaseHelper.KEY_NOTE: note,
      DatabaseHelper.KEY_ISPINNED: (isPinned) ? 1 : 0,
      DatabaseHelper.KEY_CREATED_AT: createdAt.toIso8601String(),
      DatabaseHelper.KEY_UPDATED_AT: updatedAt.toIso8601String()
    };
  }

  Note copywith(
      {String id,
      String title,
      String note,
      DateTime createdAt,
      DateTime updatedAt,
      bool isPinned}) {
    return Note(
        id: id == null ? this.id : id,
        title: title == null ? this.title : title,
        note: note == null ? this.note : note,
        createdAt: createdAt == null ? this.createdAt : createdAt,
        updatedAt: updatedAt == null ? this.updatedAt : updatedAt,
        isPinned: isPinned == null ? false : isPinned);
  }
}
