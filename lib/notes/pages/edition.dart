import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:notepadd/notes/models/note.dart';
import 'package:notepadd/notes/models/notes_data.dart';

class EditionNotePage extends StatefulWidget {
  final Note note;
  final bool estNouvelleNote;

  const EditionNotePage(this.note, this.estNouvelleNote, {super.key});

  @override
  State<EditionNotePage> createState() => _EditionNotePageState();
}

class _EditionNotePageState extends State<EditionNotePage> {
  @override
  Widget build(BuildContext context) => _buildScaffold(context);

  @override
  void initState() {
    super.initState();
    chargerNote();
  }

  QuillController _controller = QuillController.basic();

  void faireEtQuitter(Function action) {
    action();
    Navigator.pop(context);
  }

  // Back-end
  NotesData _getNotesData() => Provider.of<NotesData>(context, listen: false);


  void chargerNote() {
    final document = Document()..insert(0, widget.note.contenu);

    setState(() {
      _controller = QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0));
    });
  }

  void ajouterNote() => _getNotesData().add(widget.note);

  void modifierNote() => _getNotesData().update(widget.note);

  void sauvegarderNote() => faireEtQuitter(() {
    widget.note.contenu = _controller.document.toPlainText().trimRight();
    widget.estNouvelleNote ? ajouterNote() : modifierNote();
  });

  void supprimerNote() => faireEtQuitter(() => _getNotesData().remove(widget.note));

  // ------------------------------
  // UI

  Scaffold _buildScaffold(BuildContext context) => Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildFormTitreNote(),
          _buildQuillToolbar(),
          Expanded(child: _buildFormContenuNote())
        ]));

  AppBar _buildAppBar(BuildContext context) => AppBar(
        //title: Text(widget.estNouvelleNote ? 'Nouvelle note' : 'Modifier la note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => supprimerNote()),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => sauvegarderNote()),
        ]);

  Row _buildFormTitreNote() => Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: TextEditingController()..text = widget.note.titre,
                  decoration: const InputDecoration(
                    hintText: 'Titre de la note',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => widget.note.titre = value
                )))
          ]);

  QuillToolbar _buildQuillToolbar() => QuillToolbar.basic(
          controller: _controller,
          toolbarIconSize: 20,
          showBackgroundColorButton: false,
          showClearFormat: false,
          showHeaderStyle: false,
          showSubscript: false,
          showSuperscript: false,
          showFontFamily: false,
        );

  Container _buildFormContenuNote() => Container(
          padding: const EdgeInsets.all(8),
          child: QuillEditor.basic(controller: _controller, readOnly: false)
        );
}
