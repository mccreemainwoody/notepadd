import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class PersistanceNotes{
  final _box = Hive.box('notes');

  List<Note> _purgerNotesCorrompuesEtRetournerNotesValides() {
    var listeNotes = _box.values.toList().cast<Map<dynamic, dynamic>>();
    List<Note> notesValides = [];

    listeNotes.forEach((element) {
      try{
        notesValides.add(Note.fromJson(element));
      } catch (e) {
        print("Erreur détecté avec l'élément $element. Suppression\n$e");
        supprimerNotes(listeNotes.indexOf(element));
      }
    });

    return notesValides;
  }

  List<Note> chargerNotes() => _purgerNotesCorrompuesEtRetournerNotesValides();

  void ajouterNotes(Note note) => _box.add(note.toJson());

  void modifierNotes(int index, Note note) => _box.putAt(index, note.toJson());

  void supprimerNotes(int index) => _box.deleteAt(index);

  void viderNotes() => _box.clear();
}