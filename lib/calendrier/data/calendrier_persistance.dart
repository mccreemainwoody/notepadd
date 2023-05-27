import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepadd/global/models/bases/persistance.dart';
import '../models/event.dart';

class CalendrierPersistance extends ConstructeurPersistance<Event>{
  @override
  final box = Hive.box('events');

  List<Event> _purgerEventsCorrompusEtRetournerEventsValides()
    => purgerElementsCorrompusEtRetournerElementsValides();

  @override
  Event construireObjetPourTransfertDepuisBdDVersLocal(json) => Event.fromJson(json);

  List<Event> chargerEvents() => _purgerEventsCorrompusEtRetournerEventsValides();

  void ajouterEvent(Event event) => ajouterElement(event);

  void modifierEvent(int index, Event event) => modifierElement(index, event);

  void supprimerEvent(int index) => supprimerElement(index);

  void viderEvents() => viderElements();
}