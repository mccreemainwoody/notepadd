import 'dart:convert';
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

  factory Event.fromMap(Map<String, dynamic> Map) => Event(
      Map['titre'],
      date: DateTime.parse(Map['date']),
      couleur: Map['couleur'] == null ? null : Color(Map['couleur']),
      dateCreationParam: DateTime.parse(Map['dateCreation']),
      dateModification: Map['dateModification'] == null
          ? null
          : DateTime.parse(Map['dateModification']));

  factory Event.fromJson(String json) => Event.fromMap(jsonDecode(json));

  @override
  String toString() => 'Event(nom = $titre, couleur = $couleur, date = $date, '
      'dateCreation = $dateCreation, dateModification = $dateModification';

  @override
  Map<String, dynamic> toMap() => super.toMap()..addAll({
      'couleur': couleur == null ? null : couleur!.value,
      'date': date == null ? null : date!.toIso8601String()
    });

  void updateTout(String titre, {Color? couleur, DateTime? date}) {
    updateBase(titre);
    if (couleur != null) updateCouleur(couleur);
    if (date != null) updateDate(date);
  }

  void updateCouleur(Color couleur) => updateQuelqueChose(() => this.couleur = couleur);

  void updateDate(DateTime date) => updateQuelqueChose(() => this.date = date);
}
