import 'package:flutter/foundation.dart';
import 'package:flutter_notes/api/notes_api.dart';
import 'package:flutter_notes/model/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> listNotes = [];

  void isTogglePinnedCallback(String id) {
    int index = listNotes.indexWhere((note) => note.id == id);

    if (index >= 0) {
      listNotes[index].isPinned = !listNotes[index].isPinned;
      notifyListeners();
    }
  }

  Future<void> getAndSetNotes() async {
    listNotes = await NotesAPI().getAllNotes();
    notifyListeners();
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
    String id = await NotesAPI().postNote(note);
    note = note.copywith(id: id);
    listNotes.add(note);
    print(note.id);
    notifyListeners();
  }

  void updateNote(Note newNote) {
    int index = listNotes.indexWhere((note) => note.id == newNote.id);
    listNotes[index] = newNote;
    notifyListeners();
  }

  void deleteNote(String id) {
    listNotes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
