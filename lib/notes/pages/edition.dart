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
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    chargerNote();
  }

  void chargerNote() {
    final document = Document()..insert(0, widget.note.contenu);

    setState(() {
      _controller = QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0));
    });
  }

  void ajouterNote() {
    Provider.of<NotesData>(context, listen: false).add(widget.note);
  }

  void modifierNote() {
    widget.note.dateModification = DateTime.now();
    Provider.of<NotesData>(context, listen: false).update(widget.note);
  }

  void sauvegarderNote() {
    widget.note.contenu = _controller.document.toPlainText().trimRight();
    widget.estNouvelleNote ? ajouterNote() : modifierNote();
  }

  void supprimerNote() {
    Provider.of<NotesData>(context, listen: false).remove(widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //title: Text(widget.estNouvelleNote ? 'Nouvelle note' : 'Modifier la note'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  supprimerNote();
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  sauvegarderNote();
                  Navigator.pop(context);
                },
              ),
            ]),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: TextEditingController()
                        ..text = widget.note.titre,
                      decoration: const InputDecoration(
                        hintText: 'Titre de la note',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        widget.note.titre = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
            QuillToolbar.basic(
              controller: _controller,
              toolbarIconSize: 20,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showHeaderStyle: false,
              showSubscript: false,
              showSuperscript: false,
              showFontFamily: false,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(8),
              child:
                  QuillEditor.basic(controller: _controller, readOnly: false),
            ))
          ],
        ));
  }
}
