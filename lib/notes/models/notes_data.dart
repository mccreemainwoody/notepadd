import 'package:flutter/material.dart';
import 'package:notepadd/notes/data/persistance.dart';

import 'note.dart';


class NotesData extends ChangeNotifier{
  final db = PersistanceNotes();
  List<Note> notes = [];

  void InitialiserNotes(){
    notes = db.chargerNotes();
    notifyListeners();
  }

  List<Note> getNotes() => notes;

  void add(Note note){
    notes.add(note);
    notifyListeners();
  }

  void update(Note note){
    notes[notes.indexWhere((element) => element.id == note.id)].update(note);
    notifyListeners();
  }

  void remove(Note note){
    notes.remove(note);
    notifyListeners();
  }

  void removeSelection(List<Note> notesToRemove){
    notesToRemove.forEach((note) { notes.remove(note); });
    notifyListeners();
  }

  void clear(){
    notes.clear();
    notifyListeners();
  }

  Note creerNouvelleNote() {
    return Note(
      id: notes.length + 1,
      titre: '',
      contenu: ''
    );
  }
}