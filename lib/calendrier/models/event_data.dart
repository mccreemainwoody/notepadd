import 'package:notepadd/global/models/bases/manager_data.dart';

import '../data/calendrier_persistance.dart';
import 'event.dart';

class EventsData extends ConstructeurManagerData<Event, CalendrierPersistance> {
  @override
  CalendrierPersistance db = CalendrierPersistance();

  @override
  void chargerElements() => liste = db.chargerEvents();

  void initialiserEvents() => initialiserElements();

  List<Event> getEvents() => liste;

  List<Event> getEventsParJour(DateTime jour) => liste
      .where((event) =>
          event.date!.day == jour.day &&
          event.date!.month == jour.month &&
          event.date!.year == jour.year)
      .toList();

  Event creerNouveauEvent() => Event('Nouvel évènement',
      date: DateTime.now(), dateCreationParam: DateTime.now());
}
