import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_notes/api/notes_api.dart';
import 'package:flutter_notes/model/note.dart';
import 'package:flutter_notes/sqlite/database_helper.dart';

class NotesProvider with ChangeNotifier {
  List<Note> listNotes = [];

  Future<void> isTogglePinnedCallback(String id) async {
    int index = listNotes.indexWhere((note) => note.id == id);
    Note oldNote = listNotes.firstWhere((note) => note.id == id);

    if (index >= 0) {
      try {
        bool currentIsPinned = listNotes[index].isPinned;
        listNotes[index] = listNotes[index]
            .copywith(updatedAt: DateTime.now(), isPinned: !currentIsPinned);
        notifyListeners();
        await DatabaseHelper().updateToggle(
            listNotes[index].id, !currentIsPinned, listNotes[index].updatedAt);
        await NotesAPI().updateToggle(id, !currentIsPinned, DateTime.now());
      } catch (e) {
        listNotes[index] = listNotes[index]
            .copywith(updatedAt: oldNote.updatedAt, isPinned: oldNote.isPinned);
        notifyListeners();
        return Future.error(e);
      }
    }
  }

  Future<void> getAndSetNotes() async {
    try {
      listNotes = await NotesAPI().getAllNotes();
      await DatabaseHelper().saveAllNotes(listNotes);
      notifyListeners();
    } on SocketException {
      listNotes = await DatabaseHelper().getAllNotes();
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
      await DatabaseHelper().saveNote(note);
      note = note.copywith(id: id);
      listNotes.add(note);
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateNote(Note newNote) async {
    try {
      await NotesAPI().updateNote(newNote);
      await DatabaseHelper().updateNote(newNote);
      int index = listNotes.indexWhere((note) => note.id == newNote.id);
      listNotes[index] = newNote;
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteNote(String id) async {
    int index = listNotes.indexWhere((note) => note.id == id);
    Note note = listNotes[index];

    try {
      listNotes.removeAt(index);
      notifyListeners();
      await DatabaseHelper().deleteNote(id);
      await NotesAPI().deleteNote(id);
    } catch (e) {
      listNotes.insert(index, note);
      notifyListeners();
      return Future.error(e);
    }
  }
}
