import 'package:notepadd/global/models/bases/data.dart';

class Note extends ConstructeurData{
  String? contenu;
  bool estImportant;

  Note(
      {required String titre,
      required this.contenu,
      DateTime? dateCreationParam,
      DateTime? dateModification,
      this.estImportant = false})
      : super(titre, dateCreationParam: dateCreationParam, dateModification: dateModification);

  factory Note.fromJson(Map<dynamic, dynamic> json) {
    return Note(
        titre: json['titre'],
        contenu: json['contenu'],
        dateCreationParam: DateTime.parse(json['dateCreation']),
        dateModification: json['dateModification'] == null
            ? null
            : DateTime.parse(json['dateModification']),
        estImportant: json['estImportant'] > 0);
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({
      'contenu': contenu,
      'estImportant': estImportant ? 1 : 0
    });

  void updateTout(String titre, String? contenu, bool estImportant) {
    super.update(titre);
    updateContenu(contenu);
    updateEstImportant(estImportant);
  }

  @override
  String toString() => 'Note{titre: $titre, contenu: $contenu, dateCreation: $dateCreation, '
        'dateModification: $dateModification, isImportant: $estImportant}';

  void updateContenu(String? contenu) => this.contenu = contenu;

  void updateEstImportant(bool estImportant) => this.estImportant = estImportant;
}
