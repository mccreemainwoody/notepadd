import 'dart:convert';
import 'package:flutter/cupertino.dart';

class ConstructeurData {
  String titre;
  final DateTime dateCreation;
  DateTime? dateModification;

  ConstructeurData(this.titre, {dateCreationParam, this.dateModification})
      : dateCreation = dateCreationParam ?? DateTime.now();

  factory ConstructeurData.fromMap(Map<String, dynamic> map) => ConstructeurData(
      map['titre'],
      dateCreationParam: DateTime.parse(map['dateCreation']),
      dateModification: map['dateModification'] == null
          ? null
          : DateTime.parse(map['dateModification']));

  factory ConstructeurData.fromJson(String json) => ConstructeurData.fromMap(jsonDecode(json) as Map<String, dynamic>);


  Map<String, dynamic> toMap() => {
    'titre': titre,
    'dateCreation': dateCreation.toIso8601String(),
    'dateModification': dateModification == null
        ? null
        : dateModification!.toIso8601String()
  };

  String toJson() => jsonEncode(toMap());

  String toString() => titre;


  void updateBase(String titre) {
    updateTitre(titre);
    updateDateModification();
  }

  @protected
  void updateQuelqueChose(Function update) {
    update();
    updateDateModification();
  }

  void updateTitre(String titre) => updateQuelqueChose(() => this.titre = titre);

  void updateDateModification() => dateModification = DateTime.now();
}
