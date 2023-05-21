import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class HiveNotes{
  final _box = Hive.box('notes');

  List<Note> chargerNotes() => _box.values.toList().cast<Note>();

  void ajouterNotes(Note note) => _box.add(note);

  void modifierNotes(int index, Note note) => _box.putAt(index, note);

  void supprimerNotes(int index) => _box.deleteAt(index);

  void viderNotes() => _box.clear();
}