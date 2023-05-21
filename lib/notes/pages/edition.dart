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
    widget.note.dateCreation = DateTime.now();
    Provider.of<NotesData>(context, listen: false).add(widget.note);
  }

  void modifierNote() {
    widget.note.dateModification = DateTime.now();
    Provider.of<NotesData>(context, listen: false).update(widget.note);
  }

  void sauvegarderNote(){
    widget.note.contenu = _controller.document.toPlainText();
    widget.estNouvelleNote ? ajouterNote() : modifierNote();
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
                  Provider.of<NotesData>(context, listen: false)
                      .remove(widget.note);
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  if (widget.estNouvelleNote) {
                    ajouterNote();
                  } else {
                    modifierNote();
                  }
                  Navigator.pop(context);
                },
              ),
            ]),
        body: Column(
          children: [
            QuillToolbar.basic(
              controller: _controller,
              toolbarIconSize: 20,
              showBoldButton: false,
              showItalicButton: false,
              showUnderLineButton: false,
              showColorButton: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showQuote: false,
              showCodeBlock: false,
              showIndent: false,
              showHeaderStyle: false,
              showLink: false,
              showListNumbers: false,
              showListBullets: false,
              showListCheck: false,
              showStrikeThrough: false,
              showSubscript: false,
              showSuperscript: false,
              showFontFamily: false,
              showFontSize: false,
              showInlineCode: false,
              showSearchButton: false,
            ),

            Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: QuillEditor.basic(
                      controller: _controller,
                      readOnly: false
                  ),
                )
            )
          ],
        ));
  }
}
