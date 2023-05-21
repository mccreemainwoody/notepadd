import 'package:flutter/material.dart';
import 'package:notepadd/global/theme.dart';
import 'package:notepadd/notes/pages/acceuil.dart';


class NotesApp extends StatefulWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad+++',
      theme: ThemeApp,
      home: const NotesHome(),
    );
  }
}