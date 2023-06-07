import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:collection/collection.dart';

import 'package:notepadd/global/theme/theme.dart';
import 'package:notepadd/global/methods/appbars.dart';
import 'package:notepadd/global/models/menu.dart';
import 'package:notepadd/notes/main.dart';
import 'package:notepadd/taches/main.dart';
import 'package:notepadd/calendrier/main.dart';


void main() async {
  await Hive.initFlutter();

  await Hive.openBox('notes');
  await Hive.openBox('taches');
  await Hive.openBox('calendrier');

  initializeDateFormatting().then((_) => runApp(const NotepaddMainApp()));
}

class NotepaddMainApp extends StatelessWidget {
  const NotepaddMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad+++',
      theme: themeApp,
      home: const NotepaddAccueilPage(),
    );
  }
}

class NotepaddAccueilPage extends StatefulWidget {
  const NotepaddAccueilPage({super.key});

  final String titre = 'Notepad+++';

  @override
  State<NotepaddAccueilPage> createState() => _NotepaddAccueilPageState();
}

class _NotepaddAccueilPageState extends State<NotepaddAccueilPage> {
  @override
  Widget build(BuildContext context) => _buildScaffold(context);

  final List<Menu> _menus = [
    Menu('Notes', const NotesApp(), Colors.lightGreen),
    Menu('Tâches', const TachesApp(), Colors.redAccent),
    Menu('Calendrier', const CalendrierApp(), Colors.brown),
  ];

  Scaffold _buildScaffold(BuildContext context) => Scaffold(
        appBar: buildAppBarAccueil(context, widget.titre),
        body: Center(child: _buildMenuColumn(context, _menus.slices(2))),
      );

  Column _buildMenuColumn(BuildContext context, Iterable<List<Menu>> menusSliced) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [for (List<Menu> menus in menusSliced) _buildMenuRow(context, menus)]);

  Row _buildMenuRow(BuildContext context, List<Menu> menu) {
    List<Widget> children = [for (Menu m in menu) Expanded(child: _buildInkWell(context, m))];
    if (menu.length > 1) children.insert(1, const SizedBox(width: 4.0));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  InkWell _buildInkWell(BuildContext context, Menu menu) => InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => menu.lien)),
      child: _buildBouton(context, menu));

  Container _buildBouton(BuildContext context, Menu menu) => Container(
          height: 175,
          decoration: BoxDecoration(
            color: menu.color,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
                height: 50,
                child: Center(child: Text(
                  menu.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ))),
            SizedBox(
                height: 50,
                child: Center(child: Icon(
                  menu.getIcon(),
                  color: Colors.white,
                  size: 60,
                ))),
          ]));
}
