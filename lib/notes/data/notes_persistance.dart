import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepadd/global/models/bases/persistance.dart';
import '../models/note.dart';

class PersistanceNotes extends ConstructeurPersistance<Note>{
  @override
  final box = Hive.box('notes');

  List<Note> _purgerNotesCorrompuesEtRetournerNotesValides()
    => purgerElementsCorrompusEtRetournerElementsValides();

  @override
  Note construireObjetPourTransfertDepuisBdDVersLocal(json) => Note.fromJson(json);

  List<Note> chargerNotes() => _purgerNotesCorrompuesEtRetournerNotesValides();

  void ajouterNotes(Note note) => ajouterElement(note);

  void modifierNotes(int index, Note note) => modifierElement(index, note);

  void supprimerNotes(int index) => supprimerNotes(index);

  void viderNotes() => viderElements();
}