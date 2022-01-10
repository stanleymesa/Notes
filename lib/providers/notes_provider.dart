import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_notes/api/notes_api.dart';
import 'package:flutter_notes/model/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> listNotes = [];

  Future<void> isTogglePinnedCallback(String id) async {
    int index = listNotes.indexWhere((note) => note.id == id);

    if (index >= 0) {
      listNotes[index] = listNotes[index].copywith(
          updatedAt: DateTime.now(), isPinned: !listNotes[index].isPinned);
      await NotesAPI()
          .updateToggle(id, listNotes[index].isPinned, DateTime.now());
      notifyListeners();
    }
  }

  Future<void> getAndSetNotes() async {
    try {
      listNotes = await NotesAPI().getAllNotes();
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  List<Note> getAllNotes() {
    List<Note> _tempList = listNotes.where((note) => note.isPinned).toList();
    _tempList.addAll(listNotes.where((note) => !note.isPinned).toList());
    return _tempList;
  }

  Note getNote(String id) {
    Note note = listNotes.firstWhere((note) => note.id == id);
    return note;
  }

  Future<void> addNote(Note note) async {
    try {
      String id = await NotesAPI().postNote(note);
      note = note.copywith(id: id);
      listNotes.add(note);
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateNote(Note newNote) async {
    await NotesAPI().updateNote(newNote);
    int index = listNotes.indexWhere((note) => note.id == newNote.id);
    listNotes[index] = newNote;
    notifyListeners();
  }

  void deleteNote(String id) {
    NotesAPI().deleteNote(id);
    listNotes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
