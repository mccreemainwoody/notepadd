import 'dart:convert';
import 'package:notepadd/global/models/bases/data.dart';

class Note extends ConstructeurData {
  String? contenu;
  bool estImportant;

  Note(
      {required String titre,
      required this.contenu,
      DateTime? dateCreationParam,
      DateTime? dateModification,
      this.estImportant = false})
      : super(titre,
            dateCreationParam: dateCreationParam,
            dateModification: dateModification);


  factory Note.fromMap(Map<String, dynamic> map) => Note(
      titre: map['titre'],
      contenu: map['contenu'],
      dateCreationParam: DateTime.parse(map['dateCreation']),
      dateModification: map['dateModification'] == null
          ? null
          : DateTime.parse(map['dateModification']),
      estImportant: map['estImportant'] > 0);

  factory Note.fromJson(String json) => Note.fromMap(jsonDecode(json));


  @override
  String toString() =>
      'Note{titre: $titre, contenu: $contenu, dateCreation: $dateCreation, '
          'dateModification: $dateModification, estImportant: $estImportant}';

  @override
  Map<String, dynamic> toMap() => super.toMap()..addAll({
    'contenu': contenu,
    'estImportant': estImportant ? 1 : 0
  });

  void updateTout(String titre, String? contenu) {
    updateBase(titre);
    updateContenu(contenu);
  }

  void updateContenu(String? contenu) => updateQuelqueChose(() => this.contenu = contenu);

  void updateEstImportant() => updateQuelqueChose(() => this.estImportant ^= true);
}
