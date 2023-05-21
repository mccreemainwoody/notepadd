class Note {
  int id;
  String titre;
  String? contenu;
  DateTime dateCreation;
  DateTime? dateModification;
  bool isImportant;

  Note(
      {required this.id,
      required this.titre,
      required this.contenu,
      required this.dateCreation,
      this.dateModification,
      required this.isImportant});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        id: json['id'],
        titre: json['title'],
        contenu: json['content'],
        dateCreation: DateTime.parse(json['date']),
        dateModification:
          json['dateModification'] == null ? null : DateTime.parse(json['dateModification']),
        isImportant: json['isImportant']);
  }

  String toString() {
    return 'Note{id: $id, titre: $titre, contenu: $contenu, dateCreation: $dateCreation, dateModification: $dateModification, isImportant: $isImportant}';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': titre,
        'content': contenu,
        'dateCreation': dateCreation.toIso8601String(),
        'dateModification':
            dateModification == null ? null : dateModification!.toIso8601String(),
        'isImportant': isImportant ? 1 : 0
      };
}
