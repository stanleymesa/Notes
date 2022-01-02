import 'package:flutter/foundation.dart';
import 'package:flutter_notes/model/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> listNotes = [
    Note(
        id: 'N1',
        title: 'Catatan Materi Flutter',
        note:
            'Flutter merupakan Software Development Kit (SDK) yang bisa membantu developer dalam membuat aplikasi mobile cross platform. Kelas ini akan mempelajari pengembangan aplikasi mobile yang dapat dijalankan baik di IOS maupun di Android',
        createdAt: DateTime.parse('2021-12-18 18:45:20'),
        updatedAt: DateTime.parse('2021-12-18 21:05:10'),
        isPinned: false),
    Note(
        id: 'N2',
        title: 'Target Pembelajaran Flutter',
        note:
            'Peserta dapat mengembangkan aplikasi mobile (IOS dan Android) menggunakan flutter,\nPeserta memahami konsep pengembangan aplikasi menggunakan flutter,\nPeserta dapat menjalankan aplikasi mobile di IOS dan Android ataupun Emulator,\nPeserta memahami bahasa pemrograman Dart,\nPeserta dapat mendevelop aplikasi mobile menggunakan flutter dan dart dari dasar secara berurutan.',
        createdAt: DateTime.parse('2021-12-18 18:45:20'),
        updatedAt: DateTime.parse('2021-12-18 21:05:10'),
        isPinned: false),
    Note(
        id: 'N3',
        title: 'Belajar Flutter di ITBOX',
        note: 'Jangan lupa belajar flutter dengan video interactive di ITBOX.',
        createdAt: DateTime.parse('2021-12-18 18:45:20'),
        updatedAt: DateTime.parse('2021-12-18 21:05:10'),
        isPinned: false),
    Note(
        id: 'N4',
        title: 'Resep nasi goreng',
        note:
            'Nasi putih 1 piring\nBawang putih 2 siung, cincang halus\nKecap manis atau kecap asin sesuai selera\nSaus sambal sesuai selera\nSaus tiram sesuai selera\nGaram secukupnya\nKaldu bubuk rasa ayam atau sapi sesuai selera\nDaun bawang 1 batang, cincang halus\nTelur ayam 1 butir\nSosis ayam 1 buah, iris tipis\nMargarin atau minyak goreng 3 sdm.',
        createdAt: DateTime.parse('2021-12-18 18:45:20'),
        updatedAt: DateTime.parse('2021-12-18 21:05:10'),
        isPinned: false),
  ];

  void isTogglePinnedCallback(String id) {
    int index = listNotes.indexWhere((note) => note.id == id);

    if (index >= 0) {
      listNotes[index].isPinned = !listNotes[index].isPinned;
      notifyListeners();
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

  void addNote(Note note) {
    listNotes.add(note);
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
