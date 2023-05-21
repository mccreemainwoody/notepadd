import 'package:flutter/material.dart';
import 'package:notepadd/notes/models/notes_data.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
        create: (context) => NotesData(),
        builder: (context, child) {
          return MaterialApp(
            title: 'Notes',
            theme: themeApp,
            home: const NotesHome(),
          );
        }
    );
  }
}