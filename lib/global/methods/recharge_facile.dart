import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class StateRechargeFacile<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
    initStateCustom();
  }

  @override
  Widget build(BuildContext context) => Consumer(builder: (context, value, child) => buildScaffold());

  @protected
  void initStateCustom();

  @protected
  Scaffold buildScaffold();

  @protected
  void rechargerEcran() => setState(() {});

  @protected
  void fairePuisRecharger(void Function() action, {void Function()? methodeRechargeElement}) {
    action();
    if (methodeRechargeElement != null) methodeRechargeElement();
    rechargerEcran();
  }

  @protected
  FloatingActionButton buildBoutonAction(
          {String? heroTag,
          String? tooltip,
          required Function() onPressed,
          Icon? icon,
          Color? color}) =>
      FloatingActionButton(
        heroTag: heroTag,
        tooltip: tooltip,
        backgroundColor: color,
        onPressed: onPressed,
        child: icon,
      );
}
