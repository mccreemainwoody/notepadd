import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepadd/main.dart';
//import 'package:notepadd/notes/main.dart';
//import 'package:notepadd/taches/main.dart';
//import 'package:notepadd/calendrier/main.dart';

AppBar buildAppBarAccueil(BuildContext context, String title) => AppBar(
    title: Text(title),
    actions: [
      IconButton(
        onPressed: () => SystemNavigator.pop(),
        icon: const Icon(Icons.exit_to_app))
    ]);

AppBar buildAppBar(BuildContext context, String title) => AppBar(
    title: Text(title),
    actions: [
      IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotepaddMainApp())),
        icon: const Icon(Icons.home),
      )
    ]);

/*
NavigationBar buildNavigationBar(BuildContext context, int index) {
  return NavigationBar(
    selectedIndex: index,
    onDestinationSelected: (index) => _onDestinationSelected(context, index),
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.notes),
        selectedIcon: Icon(Icons.notes),
        label: 'Notes',
      ),
      NavigationDestination(
        icon: Icon(Icons.check_box),
        selectedIcon: Icon(Icons.check_box),
        label: 'Tâches',
      ),
      NavigationDestination(
        icon: Icon(Icons.calendar_today),
        selectedIcon: Icon(Icons.calendar_today),
        label: 'Calendrier',
      ),
    ],
  );
}
*/