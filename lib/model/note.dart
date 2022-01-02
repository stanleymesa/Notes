import 'package:flutter/foundation.dart';

class Note {
  final String id, title, note;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool isPinned;

  Note(
      {@required this.id,
      @required this.title,
      @required this.note,
      @required this.createdAt,
      @required this.updatedAt,
      this.isPinned = false});

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
        updatedAt: updatedAt == null ? this.updatedAt : updatedAt);
  }
}
