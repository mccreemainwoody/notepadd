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
    return Consumer(builder: (context, value, child) => _buildScaffold(context));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NotesData>(context, listen: false).initialiserNotes();
  }

  String formaterContenuNote(Note note){
    if (note.contenu == null) return '';
    String contenu = note.contenu!;
    if (RegExp(r'\n').hasMatch(contenu)) contenu = '${contenu.split('\n')[0]}...';
    if (contenu.length > 100) contenu = '${contenu.substring(0, 96)}...';
    return contenu;
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
                      heroTag: 'viderNotes',
                      onPressed: () {
                        _viderNotes();
                      },
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.delete_forever)
                  ),
                  FloatingActionButton(
                    heroTag: 'creerNouvelleNote',
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
        subtitle: Text(formaterContenuNote(note)),
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
