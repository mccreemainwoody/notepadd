import 'package:flutter/material.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          backgroundColor: Colors.black,
          accentColor: Colors.green,
          cardColor: Colors.black,
          errorColor: Colors.red,
          brightness: Brightness.dark,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),

        fontFamily: 'Roboto',

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize : 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),

          titleLarge: TextStyle(
            fontSize : 24.0,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize : 22.0,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize : 20.0,
            fontWeight: FontWeight.bold,
          ),

          bodyLarge: TextStyle(
            fontSize : 18.0,
          ),
          bodyMedium: TextStyle(
            fontSize : 16.0,
          ),
          bodySmall: TextStyle(
            fontSize : 12.0,
          ),
        ),
      ),
      home: const NotesHome(),
    );
  }
}