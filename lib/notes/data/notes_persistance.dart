import 'package:notepadd/global/models/bases/persistance.dart';

import '../models/note.dart';

class NotesPersistance extends ConstructeurPersistance<Note>{
  @override
  final nomBox = 'notes';

  @override
  Note construireObjetPourTransfertDepuisBdDVersLocal(json) => Note.fromJson(json);

  List<Note> chargerNotes() => chargerElements();

  void ajouterNote(Note note) => ajouterElement(note);

  void modifierNote(int index, Note note) => modifierElement(index, note);

  void supprimerNote(int index) => supprimerNote(index);

  void viderNotes() => viderElements();
}