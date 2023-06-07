import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepadd/global/methods/recharge_facile.dart';
import 'package:notepadd/global/methods/appbars.dart';

import 'package:notepadd/notes/models/note.dart';
import 'package:notepadd/notes/models/notes_data.dart';
import 'edition.dart';

class NotesHome extends StatefulWidget {
  const NotesHome({Key? key}) : super(key: key);

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends StateRechargeFacile<NotesHome> {
  @override
  void initStateCustom() => _chargerNotes();

  void fairePuisRechargerNotes(void Function() action) => fairePuisRecharger(action, methodeRechargeElement: () => _chargerNotes());


  // Back-end
  NotesData _getNotesData() => Provider.of<NotesData>(context, listen: false);

  List<Note> _getNotes() => _getNotesData().getNotes();

  void _chargerNotes() => _getNotesData().initialiserNotes();

  void _creerNouvelleNote(BuildContext context) => _editerNote(_getNotesData().creerNouvelleNote(), true);

  void _editerNote(Note note, bool estNouvelleNote) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditionNotePage(note, estNouvelleNote)
      ));

  void _supprimerNote(Note note) => fairePuisRechargerNotes(() => _getNotesData().remove(note));

  void _viderNotes() => fairePuisRechargerNotes(() => _getNotesData().clear());

  String _formaterContenuNote(Note note) {
    if (note.contenu == null) return '';
    String contenu = note.contenu!;
    if (RegExp(r'\n').hasMatch(contenu)) contenu = '${contenu.split('\n')[0]}...';
    if (contenu.length > 100) contenu = '${contenu.substring(0, 96)}...';
    return contenu;
  }

  // ----------------------------
  // UI

  @override
  Scaffold buildScaffold() => Scaffold(
      appBar: buildAppBar(context, 'Notes'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildBlocNotes(_getNotes()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: _buildMenuGestionActions(context),
            )
          ],
        ),
      ));

  Expanded _buildBlocNotes(List<Note> notes) => Expanded(
          child: notes.isEmpty
              ? const Center(child: Text('Aucune note pour l\'instant !'))
              : _buildListeNotes(notes),
      );

  Row _buildMenuGestionActions(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBoutonViderNotes(),
        _buildBoutonCreerNouvelleNote(context),
      ]);

  ListView _buildListeNotes(List<Note> notes) => ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, i) => _buildNote(notes[i]),
      );

  Card _buildNote(Note note) => Card(
        child: ListTile(
          title: Text(note.titre),
          subtitle: Text(_formaterContenuNote(note)),
          onTap: () => _editerNote(note, false),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _supprimerNote(note),
          ),
        ),
      );

  FloatingActionButton _buildBoutonCreerNouvelleNote(BuildContext context) =>
      buildBoutonAction(
        heroTag: 'creerNouvelleNote',
        onPressed: () {
          _creerNouvelleNote(context);
        },
        tooltip: 'Ajouter une note',
        icon: const Icon(Icons.add),
      );

  FloatingActionButton _buildBoutonViderNotes() => buildBoutonAction(
      heroTag: 'viderNotes',
      onPressed: () {
        _viderNotes();
      },
      tooltip: 'Supprimer toutes les notes',
      color: Colors.red,
      icon: const Icon(Icons.delete_forever));
}
