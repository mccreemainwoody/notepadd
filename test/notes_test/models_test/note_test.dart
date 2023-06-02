import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:notepadd/notes/models/note.dart';

void main() {
  test('Note: constructor', () {
    final note = Note(
      titre: 'titre',
      contenu: 'contenu',
      estImportant: true,
    );
    expect(note.titre, 'titre');
    expect(note.contenu, 'contenu');
    expect(note.estImportant, true);
    expect(note.dateCreation, isNotNull);
    expect(note.dateModification, isNull);
  });

  test('Note: fromJson', () {
    String json = jsonEncode({
      'titre': 'titre',
      'contenu': 'contenu',
      'estImportant': 1,
      'dateCreation': DateTime(2020, 1, 1).toIso8601String(),
      'dateModification': DateTime(2020, 1, 1).toIso8601String()
    });
    final note = Note.fromJson(json);
    expect(note.titre, 'titre');
    expect(note.contenu, 'contenu');
    expect(note.estImportant, true);
    expect(note.dateCreation, DateTime(2020, 1, 1));
    expect(note.dateModification, DateTime(2020, 1, 1));
  });

  test('Note: toJson', () {
    DateTime date_creation = DateTime.now();
    final note = Note(
      titre: 'titre',
      contenu: 'contenu',
      estImportant: false,
      dateCreationParam: date_creation,
      dateModification: DateTime(2020, 1, 1),
    );
    expect(note.toJson(), jsonEncode({
      'titre': 'titre',
      'dateCreation': date_creation.toIso8601String(),
      'dateModification': DateTime(2020, 1, 1).toIso8601String(),
      'contenu': 'contenu',
      'estImportant': 0,
    }));
  });

  test('Note: toString', () {
    final note = Note(
      titre: 'titre',
      contenu: 'contenu',
      estImportant: false,
    );
    expect(
        note.toString(),
        'Note{titre: titre, contenu: contenu, '
        'dateCreation: ${note.dateCreation}, dateModification: null, '
        'estImportant: false}');
  });

  test('Note: updateTitre', () {
    final note = Note(
      titre: 'titre',
      contenu: 'contenu',
      estImportant: false,
    );
    note.updateTitre('titre2');
    expect(note.titre, 'titre2');
    expect(note.contenu, 'contenu');
    expect(note.estImportant, false);
    expect(note.dateCreation, isNotNull);
    expect(note.dateModification, isNotNull);
  });

  test('Note: updateContenu', () {
    final note = Note(
      titre: 'titre',
      contenu: 'contenu',
      estImportant: false,
    );
    note.updateContenu('contenu2');
    expect(note.titre, 'titre');
    expect(note.contenu, 'contenu2');
    expect(note.estImportant, false);
    expect(note.dateCreation, isNotNull);
    expect(note.dateModification, isNotNull);
  });

  test('Note: updateEstImportant', () {
    final note = Note(
      titre: 'titre',
      contenu: 'contenu',
      estImportant: false,
    );
    note.updateEstImportant(true);
    expect(note.titre, 'titre');
    expect(note.contenu, 'contenu');
    expect(note.estImportant, true);
    expect(note.dateCreation, isNotNull);
    expect(note.dateModification, isNotNull);
  });

  test('Note: updateTout #1', () {
    final note = Note(
      titre: 'titre',
      contenu: 'contenu',
      estImportant: false,
    );
    note.updateTout('titre2', 'contenu2', true);
    expect(note.titre, 'titre2');
    expect(note.contenu, 'contenu2');
    expect(note.estImportant, true);
    expect(note.dateCreation, isNotNull);
    expect(note.dateModification, isNotNull);
  });

  test('Note: updateTout #2', () {
    final note = Note(
      titre: 'titre',
      contenu: 'contenu',
      estImportant: false,
    );
    note.updateTout('titre2', 'contenu2', true);
    expect(note.titre, 'titre2');
    expect(note.contenu, 'contenu2');
    expect(note.estImportant, true);
    expect(note.dateCreation, isNotNull);
    expect(note.dateModification, isNotNull);
  });
}
