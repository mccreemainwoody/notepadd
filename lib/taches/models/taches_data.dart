import 'package:notepadd/global/models/bases/manager_data.dart';

import 'tache.dart';
import '../data/taches_persistance.dart';

class TachesData extends ConstructeurManagerData<Tache, TachesPersistance> {
  @override
  TachesPersistance db = TachesPersistance();

  @override
  void chargerElements() => liste = db.chargerTaches();

  void initialiserTaches() => initialiserElements();

  List<Tache> getTaches() => getElements();

  Tache creerNouvelleTache() => Tache('', priorite: 0);
}