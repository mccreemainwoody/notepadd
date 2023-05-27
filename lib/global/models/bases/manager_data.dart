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
  void initialiserElements() {
    chargerElements();
  }

  @protected
  void rechargerElements() {
    chargerElements();
    notifyListeners();
  }

  @protected
  void chargerElements();

  @protected
  List<TData> getElements() => liste;

  @protected
  void add(TData element) {
    db.ajouterElement(element);
    rechargerElements();
  }

  @protected
  void update(TData element) {
    element.dateModification = DateTime.now();
    db.modifierElement(liste.indexOf(element), element);
    rechargerElements();
  }

  @protected
  void remove(TData element, {bool rechargerApresSuppression = true}) {
    db.supprimerElement(liste.indexOf(element));
    if (rechargerApresSuppression) rechargerElements();
  }

  @protected
  void removeSelection(List<TData> elementsToRemove) {
    elementsToRemove.forEach((element) {
      remove(element, rechargerApresSuppression: false);
    });
    rechargerElements();
  }

  @protected
  void clear() {
    db.viderElements();
    rechargerElements();
  }
}
