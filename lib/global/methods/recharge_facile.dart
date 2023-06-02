import 'package:flutter/material.dart';

abstract class StateRechargeFacile<T extends StatefulWidget> extends State<T>{
  @protected
  void rechargerEcran() => setState(() {});

  @protected
  void fairePuisRecharger(void Function() action, {void Function()? methodeRechargeElement}) {
    action();
    if(methodeRechargeElement != null) methodeRechargeElement();
    rechargerEcran();
  }
}
