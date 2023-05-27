import 'package:flutter/material.dart';
import 'package:notepadd/global/models/bases/data.dart';

class Event extends ConstructeurData{
  Color? couleur;

  Event(titre, {DateTime? dateCreationParam, DateTime? dateModification, this.couleur})
      : super(titre, dateCreationParam: dateCreationParam, dateModification: dateModification);

  factory Event.fromJson(Map<DateTime, dynamic> json){
    return Event(
      json['titre'],
      couleur: json['couleur'] == null ? null : Color(json['couleur']),
      dateCreationParam: DateTime.parse(json['dateCreation']),
      dateModification: json['dateModification'] == null ? null : DateTime.parse(json['dateModification'])
    );
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({
    'couleur': couleur == null ? null : couleur!.value,
  });

  @override
  String toString() => 'Event(nom = $titre, couleur = $couleur, '
      'dateCreation = $dateCreation, dateModification = $dateModification';

  void updateTout(String titre, {Color? couleur}){
    super.update(titre);
    if (couleur != null) updateCouleur(couleur);
  }

  void updateCouleur(Color couleur) => this.couleur = couleur;
}
