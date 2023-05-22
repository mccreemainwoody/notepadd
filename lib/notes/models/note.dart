class Note {
  String titre;
  String? contenu;
  final DateTime dateCreation;
  DateTime? dateModification;
  bool estImportant;

  Note(
      {required this.titre,
      required this.contenu,
      dateCreationParam,
      this.dateModification,
      this.estImportant = false})
      : dateCreation = dateCreationParam ?? DateTime.now();

  factory Note.fromJson(Map<dynamic, dynamic> json) {
    return Note(
        titre: json['title'],
        contenu: json['content'],
        dateCreationParam: DateTime.parse(json['dateCreation']),
        dateModification: json['dateModification'] == null
            ? null
            : DateTime.parse(json['dateModification']),
        estImportant: json['estImportant'] > 0);
  }

  String toString() {
    return 'Note{titre: $titre, contenu: $contenu, dateCreation: $dateCreation, dateModification: $dateModification, isImportant: $estImportant}';
  }

  Map<String, dynamic> toJson() => {
        'title': titre,
        'content': contenu,
        'dateCreation': dateCreation.toIso8601String(),
        'dateModification': dateModification == null
            ? null
            : dateModification!.toIso8601String(),
        'estImportant': estImportant ? 1 : 0
      };

  void update(Note note) {
    updateTitre(note.titre);
    updateContenu(note.contenu);
    updateDateModification();
    updateIsImportant(note.estImportant);
  }

  void updateTitre(String titre) {
    this.titre = titre;
  }

  void updateContenu(String? contenu) {
    this.contenu = contenu;
  }

  void updateDateModification() {
    dateModification = DateTime.now();
  }

  void updateIsImportant(bool estImportant) {
    this.estImportant = estImportant;
  }
}
