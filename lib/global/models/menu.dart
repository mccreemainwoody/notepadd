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

  IconData getIcon(){
    return icons[title];
  }

  Menu(this.title, this.lien, this.color);
}