import 'package:flutter/material.dart';

import 'note.dart';

class NotesData extends ChangeNotifier{
  List<Note> notes = [
    Note(
        id: 1,
        titre: 'Amogus',
        contenu: 'amogus',
        dateCreation: DateTime.now(),
        isImportant: false
    ),
    Note(
        id: 2,
        titre: 'waltuh',
        contenu: 'jesse',
        dateCreation: DateTime.now(),
        isImportant: false
    ),
    Note(
        id: 402,
        titre: 'gus',
        contenu: 'sug',
        dateCreation: DateTime.now(),
        isImportant: false
    ),
  ];

  List<Note> getNotes(){
    return notes;
  }

  void add(Note note){
    notes.add(note);
    notifyListeners();
  }

  void remove(Note note){
    notes.remove(note);
    notifyListeners();
  }

  void removeSelection(List<Note> notesToRemove){
    notesToRemove.forEach((note) {
      notes.remove(note);
    });
    notifyListeners();
  }

  void update(Note note){
    notes[notes.indexWhere((element) => element.id == note.id)] = note;
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
      contenu: '',
      dateCreation: DateTime.now(),
      dateModification: null,
      isImportant: false
    );
  }
}