import 'dart:convert';

import 'package:flutter_notes/model/note.dart';
import 'package:http/http.dart' as http;

class NotesAPI {
  Future<List<Note>> getAllNotes() async {
    List<Note> listNotes = [];

    final uri = Uri.parse(
        "https://notes-flutter-61f0d-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json");
    final response = await http.get(uri);

    final results = json.decode(response.body) as Map<String, dynamic>;

    if (results == null) {
      return listNotes;
    }

    results.forEach((key, value) {
      listNotes.add(Note(
          id: key,
          title: value['title'],
          note: value['note'],
          createdAt: DateTime.parse(value['created_at']),
          updatedAt: DateTime.parse(value['updated_at']),
          isPinned: (value['isPinned'] == 'true') ? true : false));
    });

    return listNotes;
  }

  Future<String> postNote(Note note) async {
    final uri = Uri.parse(
        "https://notes-flutter-61f0d-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json");

    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'created_at': note.createdAt.toIso8601String(),
      'updated_at': note.updatedAt.toIso8601String(),
      'isPinned': note.isPinned
    };

    final jsonEncode = json.encode(map);
    final response = await http.post(uri, body: jsonEncode);

    return json.decode(response.body)['name'];
  }
}
