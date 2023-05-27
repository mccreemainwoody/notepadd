import 'package:notepadd/global/models/bases/manager_data.dart';
import 'event.dart';
import '../data/calendrier_persistance.dart';

class EventsData extends ConstructeurManagerData<Event, CalendrierPersistance>{
  @override
  CalendrierPersistance db = CalendrierPersistance();

  @override
  void chargerElements() => liste = db.chargerEvents();


  void initialiserEvents() => initialiserElements();

  List<Event> getEvents() => liste;
}