import 'package:flutter/cupertino.dart';

import 'data.dart';
import 'persistance.dart';

abstract class ConstructeurManagerData<TData extends ConstructeurData, TPersistance extends ConstructeurPersistance>
    extends ChangeNotifier {
  @protected
  late final TPersistance db;

  @protected
  late List<TData> liste = [];

  @protected
  void faireEtRechargerElements(void Function() action) {
    action();
    rechargerElements();
  }

  @protected
  void initialiserElements() => chargerElements();

  @protected
  void rechargerElements() {
    chargerElements();
    notifyListeners();
  }

  @protected
  void chargerElements();

  @protected
  List<TData> getElements() => liste;

  void add(TData element) => faireEtRechargerElements(() => db.ajouterElement(element));

  void update(TData element) => faireEtRechargerElements(() {
    element.dateModification = DateTime.now();
    db.modifierElement(liste.indexOf(element), element);
  });

  void remove(TData element, {bool rechargerApresSuppression = true}) {
    db.supprimerElement(liste.indexOf(element));
    if (rechargerApresSuppression) rechargerElements();
  }

  void removeSelection(List<TData> elementsToRemove) => faireEtRechargerElements(() => elementsToRemove.forEach((element) => remove(element, rechargerApresSuppression: false)));

  void clear() => faireEtRechargerElements(() => db.viderElements());
}
