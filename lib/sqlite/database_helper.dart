import 'package:flutter_notes/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const DATABASE_NAME = 'notes.db';
  static const KEY_TABLE = 'notes';
  static const KEY_ID = 'id';
  static const KEY_TITLE = 'title';
  static const KEY_NOTE = 'note';
  static const KEY_ISPINNED = 'isPinned';
  static const KEY_CREATED_AT = 'created_at';
  static const KEY_UPDATED_AT = 'updated_at';

  static Future<Database> init() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, DATABASE_NAME),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $KEY_TABLE (
            $KEY_ID TEXT PRIMARY KEY,
            $KEY_TITLE TEXT,
            $KEY_NOTE TEXT,
            $KEY_ISPINNED INTEGER,
            $KEY_CREATED_AT TEXT,
            $KEY_UPDATED_AT TEXT
          )
        ''');
      },
    );
  }

  Future<List<Note>> getAllNotes() async {
    final db = await DatabaseHelper.init();
    final results = await db.query(KEY_TABLE);

    List<Note> listNotes = [];
    results.forEach((mapNote) {
      listNotes.add(Note.fromDB(mapNote));
    });

    return listNotes;
  }

  Future<void> saveAllNotes(List<Note> listNotes) async {
    final db = await DatabaseHelper.init();
    final batch = db.batch();

    listNotes.forEach((note) {
      batch.insert(KEY_TABLE, note.toDB(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });

    await batch.commit();
  }

  Future<void> updateNote(Note note) async {
    final db = await DatabaseHelper.init();
    await db.update(KEY_TABLE, note.toDB(),
        where: '$KEY_ID = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(String id) async {
    final db = await DatabaseHelper.init();
    await db.delete(KEY_TABLE, where: '$KEY_ID = ?', whereArgs: [id]);
  }

  Future<void> updateToggle(
      String id, bool isPinned, DateTime updated_at) async {
    final db = await DatabaseHelper.init();
    await db.update(
        KEY_TABLE,
        {
          'id': id,
          'isPinned': isPinned ? 1 : 0,
          'updated_at': updated_at.toIso8601String()
        },
        where: '$KEY_ID = ?',
        whereArgs: [id]);
  }

  Future<void> saveNote(Note note) async {
    final db = await DatabaseHelper.init();
    await db.insert(KEY_TABLE, note.toDB());
  }
}
