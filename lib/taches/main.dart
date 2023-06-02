import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepadd/global/theme.dart';
import 'package:notepadd/taches/models/taches_data.dart';

import 'pages/accueil.dart';

class TachesApp extends StatefulWidget {
  const TachesApp({Key? key}) : super(key: key);

  @override
  State<TachesApp> createState() => _TachesAppState();
}

class _TachesAppState extends State<TachesApp> {
  @override
  Widget build(BuildContext context) {
    print("Je cuisine là");
    return ChangeNotifierProvider(
        create: (context) => TachesData(),
        builder: (context, child) {
          return MaterialApp(
            title: 'Tâches App',
            theme: themeApp,
            home: const TachesHome(),
          );
        }
    );
  }
}
