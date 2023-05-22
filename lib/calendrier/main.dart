import 'package:flutter/material.dart';


class CalendrierApp extends StatefulWidget {
  const CalendrierApp({Key? key}) : super(key: key);

  @override
  State<CalendrierApp> createState() => _CalendrierAppState();
}

class _CalendrierAppState extends State<CalendrierApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calendrier App',
      home: Calendrier(),
    );
  }
}

class Calendrier extends StatefulWidget {
  const Calendrier({Key? key}) : super(key: key);

  @override
  State<Calendrier> createState() => _CalendrierState();
}

class _CalendrierState extends State<Calendrier> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Calendrier')
    );
  }
}