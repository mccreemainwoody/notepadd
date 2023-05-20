import 'package:flutter/material.dart';

class NotepaddFontStyle{
  static const styleTexteBase = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final TextStyle styleTexteTitre = styleTexteBase.copyWith(
    fontSize: 28.0,
    color: Colors.blue,
  );
  static final TextStyle styleTexteSousTitre = styleTexteBase.copyWith(
    fontSize: 22.0,
  );
  static final TextStyle styleTexteHeader = styleTexteBase.copyWith(
    fontSize: 20.0,
  );
  static final TextStyle styleTexteRegular = styleTexteBase.copyWith(
    fontSize: 18.0,
  );
  static final TextStyle styleTexteSubHeader = styleTexteBase.copyWith(
    fontSize: 26.0,
  );

  static final TextStyle styleTexteErreur = styleTexteBase.copyWith(
    color: Colors.red,
    fontSize: 22.0,
  );
}