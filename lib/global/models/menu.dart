import 'package:flutter/material.dart';

class Menu{
  String title;
  Color color;
  StatefulWidget lien;

  Map icons = const {
    'Notes': Icons.notes,
    'Tâches': Icons.check_box,
    'Calendrier': Icons.calendar_month
  };

  Menu(this.title, this.lien, this.color);

  IconData getIcon() => icons[title];
}