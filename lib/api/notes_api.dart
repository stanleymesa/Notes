import 'dart:convert';
import 'dart:io';

import 'package:flutter_notes/model/note.dart';
import 'package:http/http.dart' as http;

class NotesAPI {
  Future<List<Note>> getAllNotes() async {
    List<Note> listNotes = [];

    final uri = Uri.parse(
        "https://notes-flutter-61f0d-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
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
      } else {
        throw Exception();
      }
    } on SocketException {
      throw 'Tidak ada internet';
    } catch (e) {
      throw Exception('Error, terjadi kesalahan');
    }
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

    try {
      final jsonEncode = json.encode(map);
      final response = await http.post(uri, body: jsonEncode);

      if (response.statusCode == 200) {
        return json.decode(response.body)['name'];
      } else {
        throw Exception();
      }
    } on SocketException {
      throw 'Tidak ada internet';
    } catch (e) {
      throw Exception('Error, terjadi kesalahan');
    }
  }

  Future<void> updateNote(Note note) async {
    final uri = Uri.parse(
        "https://notes-flutter-61f0d-default-rtdb.asia-southeast1.firebasedatabase.app/notes/${note.id}.json");

    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'updated_at': note.updatedAt.toIso8601String()
    };

    final jsonEncode = json.encode(map);
    final response = await http.patch(uri, body: jsonEncode);
  }

  Future<void> updateToggle(
      String id, bool isPinned, DateTime updated_at) async {
    final uri = Uri.parse(
        "https://notes-flutter-61f0d-default-rtdb.asia-southeast1.firebasedatabase.app/notes/${id}.json");

    Map<String, dynamic> map = {
      'isPinned': isPinned,
      'updated_at': updated_at.toIso8601String()
    };

    final jsonEncode = json.encode(map);
    final response = await http.patch(uri, body: jsonEncode);
  }

  Future<void> deleteNote(String id) async {
    final uri = Uri.parse(
        "https://notes-flutter-61f0d-default-rtdb.asia-southeast1.firebasedatabase.app/notes/${id}.json");

    final response = await http.delete(uri);
  }
}
