import 'package:notepadd/global/models/bases/manager_data.dart';

import 'note.dart';
import '../data/notes_persistance.dart';

class NotesData extends ConstructeurManagerData<Note, PersistanceNotes> {
  @override
  PersistanceNotes db = PersistanceNotes();

  @override
  void chargerElements() => liste = db.chargerNotes();

  void initialiserNotes() => initialiserElements();

  List<Note> getNotes() => getElements();

  Note creerNouvelleNote() => Note(titre: '', contenu: '');
}
