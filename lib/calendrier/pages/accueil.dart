import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:notepadd/global/methods/recharge_facile.dart';
import 'package:notepadd/global/methods/appbars.dart';

import 'package:notepadd/calendrier/models/event.dart';
import 'package:notepadd/calendrier/models/event_data.dart';
import 'edition.dart';

class CalendrierHome extends StatefulWidget {
  const CalendrierHome({Key? key}) : super(key: key);

  @override
  State<CalendrierHome> createState() => _CalendrierHomeState();
}

class _CalendrierHomeState extends StateRechargeFacile<CalendrierHome> {
  @override
  void initStateCustom() => _getEventsData().initialiserEvents();


  // Back-end
  final DateTime _today = DateTime.now();
  DateTime _jourSelectionne = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  EventsData _getEventsData() => Provider.of<EventsData>(context, listen: false);

  void _creerNouvelEvent() => _editerEvent(_getEventsData().creerNouveauEvent(), true);

  void _editerEvent(Event event, bool estNouvelEvent) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditionEventPage(event, estNouvelEvent))
  );

  void _supprimerEvent(Event event) => fairePuisRecharger(() => _getEventsData().remove(event));

  void _viderEvents() => fairePuisRecharger(() => _getEventsData().clear());


  // ----------------------------
  // UI

  @override
  Scaffold buildScaffold() => Scaffold(
      appBar: buildAppBar(context, 'Calendrier'),
      body: Column(
        children: [
          _buildCalendrier(),
          Expanded(child: _buildListeEvents()),
          Padding(padding: const EdgeInsets.all(12.0), child: _buildMenuGestionActions())
        ]));

  TableCalendar _buildCalendrier() => TableCalendar(
      locale: 'fr_FR',
      firstDay: DateTime.utc(_today.year - 10),
      lastDay: DateTime.utc(_today.year + 10),
      focusedDay: _today,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarFormat: _calendarFormat,
      onDaySelected: _onDaySelected,
      onFormatChanged: _onFormatChanged,
      onPageChanged: _onPageChanged,
      selectedDayPredicate: (day) => isSameDay(_jourSelectionne, day),
      availableGestures: AvailableGestures.all,
      eventLoader: _eventLoader,
  );

  ListView _buildListeEvents() {
    List<Event> _eventsPourCeJour = _getEventsForDay(_jourSelectionne);

    return ListView.builder(
      itemCount: _eventsPourCeJour.length,
      itemBuilder: (context, index) => _buildTileEvent(_eventsPourCeJour[index]),
    );
  }

  ListTile _buildTileEvent(Event event) => ListTile(
      title: Text(event.titre),
      subtitle: Text('${event.date?.hour}:${event.date?.minute}'),
      onTap: () => _editerEvent(event, false),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _supprimerEvent(event),
      ));

  Row _buildMenuGestionActions() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBoutonAjouterEvent(),
          _buildBoutonViderEvents(),
        ]);

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) =>
      setState(() => _jourSelectionne = selectedDay);

  void _onFormatChanged(CalendarFormat format) =>
      setState(() => _calendarFormat = format);

  void _onPageChanged(DateTime focusedDay) => _jourSelectionne = focusedDay;

  List<Event> _eventLoader(DateTime day) => _getEventsForDay(day);

  List<Event> _getEventsForDay(DateTime day) => _getEventsData().getEventsParJour(day);

  FloatingActionButton _buildBoutonAjouterEvent() => buildBoutonAction(
      heroTag: 'ajouter-event',
      tooltip: 'Supprimer tous les événements',
      onPressed: _viderEvents,
      color: Colors.red,
      icon: const Icon(Icons.delete));

  FloatingActionButton _buildBoutonViderEvents() => buildBoutonAction(
      heroTag: 'vider-events',
      tooltip: 'Ajouter un événement',
      onPressed: _creerNouvelEvent,
      color: Colors.green,
      icon: const Icon(Icons.add));
}
