import 'dart:convert';
import 'package:notepadd/global/models/bases/data.dart';

class Tache extends ConstructeurData {
  bool estFait = false;
  bool estImportant = false;
  int priorite = 0;

  Tache(String titre,
      {this.estFait = false,
      this.estImportant = false,
      this.priorite = 0,
      DateTime? dateCreationParam,
      DateTime? dateModification})
      : super(titre,
            dateCreationParam: dateCreationParam,
            dateModification: dateModification);

  factory Tache.fromMap(Map<String, dynamic> map) => Tache(
        map['titre'],
        estFait: map['estFait'],
        estImportant: map['estImportant'],
        priorite: map['priorite'],
        dateCreationParam: DateTime.parse(map['dateCreation']),
        dateModification: map['dateModification'] == null
            ? null
            : DateTime.parse(map['dateModification']),
      );

  factory Tache.fromJson(String json) => Tache.fromMap(jsonDecode(json));

  @override
  String toString() =>
      'Tache{titre: $titre, estFait: $estFait, estImportant: $estImportant, '
      'priorite: $priorite, dateCreation: $dateCreation, dateModification: $dateModification}';

  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..addAll({
      'estFait': estFait,
      'estImportant': estImportant,
      'priorite': priorite,
    });

  void updateTout(String titre, int priorite, bool estImportant, bool estFait) {
    updateBase(titre);
    updateEstFait(estFait);
    updateEstImportant(estImportant);
    updatePriorite(priorite);
  }

  void updateEstFait(bool estFait) => updateQuelqueChose(() => this.estFait = estFait);

  void updateEstImportant(bool estImportant) => updateQuelqueChose(() => this.estImportant = estImportant);

  void updatePriorite(int priorite) => updateQuelqueChose(() => this.priorite = priorite);
}
