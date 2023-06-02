import 'package:notepadd/global/models/bases/persistance.dart';

import '../models/tache.dart';

class TachesPersistance extends ConstructeurPersistance<Tache> {
  @override
  final nomBox = 'taches';

  @override
  Tache construireObjetPourTransfertDepuisBdDVersLocal(json) => Tache.fromJson(json);

  List<Tache> chargerTaches() => chargerElements();

  void ajouterTache(Tache tache) => ajouterElement(tache);

  void modifierTache(int index, Tache tache) => modifierElement(index, tache);

  void supprimerTache(int index) => supprimerElement(index);

  void viderTaches() => viderElements();
}