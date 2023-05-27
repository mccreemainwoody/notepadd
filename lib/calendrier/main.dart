import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/theme.dart';
import 'pages/accueil.dart';

import '../notes/models/notes_data.dart';

class CalendrierApp extends StatefulWidget {
  const CalendrierApp({Key? key}) : super(key: key);

  @override
  State<CalendrierApp> createState() => _CalendrierAppState();
}

class _CalendrierAppState extends State<CalendrierApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => NotesData(),
        builder: (context, child) {
          return MaterialApp(
            title: 'Notes',
            theme: themeApp,
            home: const CalendrierHome(),
          );
        }
    );
  }
}
