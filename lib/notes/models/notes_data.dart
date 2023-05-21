import 'package:flutter/material.dart';

import 'note.dart';


class NotesData extends ChangeNotifier{
  List<Note> notes = [
    Note(
        id: 1,
        titre: 'Amogus',
        contenu: 'amogus'
    ),
    Note(
        id: 2,
        titre: 'waltuh',
        contenu: 'jesse'
    ),
    Note(
        id: 402,
        titre: 'gus',
        contenu: 'sug'
    ),
  ];

  List<Note> getNotes(){
    return notes;
  }

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