import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'data.dart';

abstract class ConstructeurPersistance<T extends ConstructeurData> {
  @protected
  late final String nomBox;

  @protected
  late final Box<dynamic> box = Hive.box(nomBox);

  @protected
  List<T> _purgerElementsCorrompusEtRetournerElementsValides() {
    var listeElements = box.values.toList();
    List<T> elementsValides = [];

    for (var element in listeElements) {
      try{
        elementsValides.add(construireObjetPourTransfertDepuisBdDVersLocal(element));
      } catch (e) {
        print("Erreur détecté avec l'élément $element. Suppression\n$e");
        supprimerElement(listeElements.indexOf(element));
      }
    }

    return elementsValides;
  }

  @protected
  T construireObjetPourTransfertDepuisBdDVersLocal(json);

  List<T> chargerElements() => _purgerElementsCorrompusEtRetournerElementsValides();

  void ajouterElement(T element) => box.add(element.toJson());

  void modifierElement(int index, T element) => box.putAt(index, element.toJson());

  void supprimerElement(int index) => box.deleteAt(index);

  void viderElements() => box.clear();
}
