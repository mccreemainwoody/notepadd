import 'package:notepadd/global/models/bases/persistance.dart';

import '../models/event.dart';

class CalendrierPersistance extends ConstructeurPersistance<Event> {
  @override
  final nomBox = 'calendrier';

  @override
  Event construireObjetPourTransfertDepuisBdDVersLocal(json) => Event.fromJson(json);

  List<Event> chargerEvents() => chargerElements();

  void ajouterEvent(Event event) => ajouterElement(event);

  void modifierEvent(int index, Event event) => modifierElement(index, event);

  void supprimerEvent(int index) => supprimerElement(index);

  void viderEvents() => viderElements();
}
