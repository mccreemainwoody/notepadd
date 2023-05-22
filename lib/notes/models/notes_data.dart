import 'package:flutter/material.dart';
import 'package:notepadd/notes/data/persistance.dart';

import 'note.dart';


class NotesData extends ChangeNotifier{
  final db = PersistanceNotes();
  List<Note> notes = [];

  void initialiserNotes(){
    chargerNotes();
  }

  void rechargerNotes(){
    chargerNotes();
    notifyListeners();
  }

  void chargerNotes(){
    notes = db.chargerNotes();
  }

  List<Note> getNotes() => notes;

  void add(Note note){
    db.ajouterNotes(note);
    rechargerNotes();
  }

  void update(Note note){
    note.dateModification = DateTime.now();
    db.modifierNotes(notes.indexOf(note), note);
    rechargerNotes();
  }

  void remove(Note note, {bool rechargerApresSuppression = false}){
    db.supprimerNotes(notes.indexOf(note));
    if(!rechargerApresSuppression) rechargerNotes();
  }

  void removeSelection(List<Note> notesToRemove){
    notesToRemove.forEach((note) { remove(note, rechargerApresSuppression: true); });
    rechargerNotes();
  }

  void clear(){
    db.viderNotes();
    rechargerNotes();
  }

  Note creerNouvelleNote() {
    return Note(
      titre: '',
      contenu: ''
    );
  }
}