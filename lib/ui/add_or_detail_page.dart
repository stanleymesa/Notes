import 'package:flutter/material.dart';
import 'package:flutter_notes/model/note.dart';
import 'package:flutter_notes/providers/notes_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddOrDetailPage extends StatefulWidget {
  @override
  State<AddOrDetailPage> createState() => _AddOrDetailPageState();
}

class _AddOrDetailPageState extends State<AddOrDetailPage> {
  // Hooks
  Note _note =
      Note(id: null, title: '', note: '', createdAt: null, updatedAt: null);

  final _formKey = GlobalKey<FormState>();

  bool _init = true;
  String _idFromMain;

  // End Hooks

  void saveNote() {
    final _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _formKey.currentState.save();

    // Jika Update Note
    if (_idFromMain != 'null') {
      _note = _note.copywith(updatedAt: DateTime.now());
      _notesProvider.updateNote(_note);
    }
    // Jika Add Note
    else {
      _note =
          _note.copywith(createdAt: DateTime.now(), updatedAt: DateTime.now());
      _notesProvider.addNote(_note);
    }
    Navigator.of(context).pop();
  }

  String _convertTime(DateTime dateTime) {
    int diff = DateTime.now().difference(dateTime).inDays;
    if (diff > 0) return DateFormat('dd-MM-yyyy').format(dateTime);
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      _idFromMain = ModalRoute.of(context).settings.arguments.toString();
      if (_idFromMain != 'null') {
        _note = Provider.of<NotesProvider>(context, listen: false)
            .getNote(_idFromMain);
      }
      _init = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => saveNote(),
              icon: Icon(
                Icons.save_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          _note = _note.copywith(title: value);
                        },
                        initialValue: _note.title,
                        decoration: const InputDecoration(labelText: 'Judul'),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _note = _note.copywith(note: value);
                        },
                        initialValue: _note.note,
                        decoration: const InputDecoration(labelText: 'Note'),
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _idFromMain != 'null'
              ? Positioned(
                  bottom: 10,
                  right: 10,
                  child: Text('Updated At : ${_convertTime(_note.updatedAt)}'))
              : SizedBox()
        ],
      ),
    );
  }
}
