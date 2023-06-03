import 'package:flutter/material.dart';

class Menu{
  String title;
  Color color;
  Widget lien;

  Map icons = const {
    'Notes': Icons.notes,
    'Tâches': Icons.check_box,
    'Calendrier': Icons.calendar_month
  };

  Menu(this.title, this.lien, this.color);

  @override
  String toString() => 'Menu{titre: $title, couleur : $color, lien : $lien}';

  IconData getIcon() => icons[title];
}