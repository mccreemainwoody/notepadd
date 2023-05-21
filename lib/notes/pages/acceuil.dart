import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../models/notes_data.dart';
import 'edition.dart';

class NotesHome extends StatefulWidget {
  const NotesHome({Key? key}) : super(key: key);

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, value, child) => _buildScaffold(context));
  }

  void _creerNouvelleNote(BuildContext context) {
    Note nouvelleNote =
        Provider.of<NotesData>(context, listen: false).creerNouvelleNote();
    _editerNote(nouvelleNote, true);
  }

  void _editerNote(Note note, bool estNouvelleNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditionNotePage(note, estNouvelleNote)
        )
    );
  }

  void _supprimerNote(Note note) {
    Provider.of<NotesData>(context, listen: false).remove(note);
  }

  void _viderNotes() {
    Provider.of<NotesData>(context, listen: false).clear();
  }

  Scaffold _buildScaffold(BuildContext context) {
    NotesData notesData = Provider.of<NotesData>(context);
    List<Note> notes = notesData.getNotes();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child:
                notes.isEmpty
                    ? const Center(
                        child: Text('Aucune note pour l\'instant !'),
                      )
                    : ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, i) {
                          return _buildNote(notes[i], notesData);
                        },
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                      onPressed: () {
                        _viderNotes();
                      },
                      child: const Icon(Icons.delete_forever)
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _creerNouvelleNote(context);
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Card _buildNote(Note note, NotesData notesData) {
    return Card(
      child: ListTile(
        title: Text(note.titre),
        subtitle: Text(note.contenu ?? ''),
        onTap: () {
          _editerNote(note, false);
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            _supprimerNote(note);
          },
        ),
      ),
    );
  }
}
