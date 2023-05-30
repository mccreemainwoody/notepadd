import 'package:flutter/material.dart';
import 'package:notepadd/global/models/bases/data.dart';

class Event extends ConstructeurData {
  Color? couleur;
  DateTime? date;

  Event(titre,
      {DateTime? dateCreationParam,
      DateTime? dateModification,
      this.couleur,
      this.date})
      : super(titre,
            dateCreationParam: dateCreationParam,
            dateModification: dateModification);

  factory Event.fromJson(Map<String, dynamic> json) => Event(json['titre'],
      date: DateTime.parse(json['date']),
      couleur: json['couleur'] == null ? null : Color(json['couleur']),
      dateCreationParam: DateTime.parse(json['dateCreation']),
      dateModification: json['dateModification'] == null
          ? null
          : DateTime.parse(json['dateModification']));

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'couleur': couleur == null ? null : couleur!.value,
      'date': date == null ? null : date!.toIso8601String()
    });

  @override
  String toString() => 'Event(nom = $titre, couleur = $couleur, date = $date, '
      'dateCreation = $dateCreation, dateModification = $dateModification';

  void updateTout(String titre, {Color? couleur, DateTime? date}) {
    updateBase(titre);
    if (couleur != null) updateCouleur(couleur);
    if (date != null) updateDate(date);
  }

  void updateCouleur(Color couleur) => this.couleur = couleur;

  void updateDate(DateTime date) => this.date = date;
}
