import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

//import 'package:notepadd/global/font_global.dart';
import 'package:notepadd/global/models/menu.dart';
import 'package:notepadd/notes/main.dart';
import 'package:notepadd/todo/main.dart';
import 'package:notepadd/calendrier/main.dart';

import 'package:notepadd/global/theme.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('notes');
  await Hive.openBox('todo');
  await Hive.openBox('calendrier');

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad+++',
      theme: themeApp,
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
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => menu.lien)
      );
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
