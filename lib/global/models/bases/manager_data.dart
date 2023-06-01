import 'package:flutter/cupertino.dart';

import 'data.dart';
import 'persistance.dart';

abstract class ConstructeurManagerData<TData extends ConstructeurData,
    TPersistance extends ConstructeurPersistance> extends ChangeNotifier {
  @protected
  late final TPersistance db;

  @protected
  late List<TData> liste = [];

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

  void add(TData element) {
    db.ajouterElement(element);
    rechargerElements();
  }

  void update(TData element) {
    element.dateModification = DateTime.now();
    db.modifierElement(liste.indexOf(element), element);
    rechargerElements();
  }

  void remove(TData element, {bool rechargerApresSuppression = true}) {
    db.supprimerElement(liste.indexOf(element));
    if (rechargerApresSuppression) rechargerElements();
  }

  void removeSelection(List<TData> elementsToRemove) {
    elementsToRemove.forEach((element) {
      remove(element, rechargerApresSuppression: false);
    });
    rechargerElements();
  }

  void clear() {
    db.viderElements();
    rechargerElements();
  }
}
