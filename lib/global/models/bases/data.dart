import 'package:flutter/cupertino.dart';

class ConstructeurData {
  String titre;
  final DateTime dateCreation;
  DateTime? dateModification;

  ConstructeurData(this.titre, {dateCreationParam, this.dateModification})
      : dateCreation = dateCreationParam ?? DateTime.now();

  factory ConstructeurData.fromJson(Map<dynamic, dynamic> json) =>
      ConstructeurData(json['titre']);

  ConstructeurData fromJson(Map<dynamic, dynamic> json) =>
      ConstructeurData.fromJson(json);

  Map<String, dynamic> toJson() => {
        'titre': titre,
        'dateCreation': dateCreation.toIso8601String(),
        'dateModification': dateModification == null
            ? null
            : dateModification!.toIso8601String()
      };

  String toString() => titre;

  @protected
  void updateBase(String titre) {
    updateTitre(titre);
    updateDateModification();
  }

  void updateTitre(String titre) => this.titre = titre;

  void updateDateModification() => dateModification = DateTime.now();
}
