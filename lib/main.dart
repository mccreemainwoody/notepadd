import 'package:flutter/material.dart';
//import 'package:notepadd/global/font.dart';
import 'package:notepadd/global/models/menu.dart';
import 'package:notepadd/notes/main.dart';
import 'package:notepadd/todo/main.dart';
import 'package:notepadd/calendrier/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          )
        ),
      ),

      home: const MyHomePage(title: 'Notepad+++'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final _menus = [
    Menu('Notes', const NotesApp(), Colors.lightGreen),
    Menu('Tâches', const ToDoApp(), Colors.redAccent),
    Menu('Calendrier', const CalendrierApp(), Colors.brown)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildInkWellSquare(context, _menus[0], 195),
                _buildInkWellSquare(context, _menus[1], 195)
              ],
            ),

            _buildInkWellRectangle(context, _menus[2], 195, 195, '/')
          ],
        ),
      ),
    );
  }
}


_buildInkWellSquare(BuildContext context, Menu menu, double size) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => menu.lien)
      );
    },
    child: _buildSquare(context, menu, size)
  );
}

_buildInkWellRectangle(BuildContext context, Menu menu, double width, double height, String link) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, link);
    },
    child: _buildRectangle(context, menu, width, height),
  );
}


_buildSquare(BuildContext context, Menu menu, double size) {
  return _buildStructure(context, menu, size, size);
}

_buildRectangle(BuildContext context, Menu menu, double width, double height) {
  return _buildStructure(context, menu, width, height);
}


_buildStructure(BuildContext context, Menu menu, double width, double height){
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: menu.color,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                menu.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Icon(
                menu.getIcon(),
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
        ],
      )
  );
}
