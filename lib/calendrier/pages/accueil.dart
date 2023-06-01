import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:notepadd/calendrier/models/event.dart';
import 'package:notepadd/calendrier/models/event_data.dart';
import 'edition.dart';

class CalendrierHome extends StatefulWidget {
  const CalendrierHome({Key? key}) : super(key: key);

  @override
  State<CalendrierHome> createState() => _CalendrierHomeState();
}

class _CalendrierHomeState extends State<CalendrierHome> {
  final DateTime _today = DateTime.now();
  DateTime _jourSelectionne = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  EventsData _getEventsData() =>
      Provider.of<EventsData>(context, listen: false);

  void _creerNouvelEvent() {
    Event nouvelEvent = _getEventsData().creerNouveauEvent();
    _editerEvent(nouvelEvent, true);
  }

  void _editerEvent(Event event, bool estNouvelEvent) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditionEventPage(event, estNouvelEvent)
      )
  );

  void _supprimerEvent(Event event) => _getEventsData().remove(event);

  void _viderEvents() => _getEventsData().clear();

  @override
  void initState() {
    super.initState();
    _getEventsData().initialiserEvents();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Calendrier'),
      ),
      body: Column(
        children: [
          _buildCalendrier(),
          _buildListeEvents(),
          _buildBoutonsActions(),
        ],
      )
  );

  TableCalendar _buildCalendrier() => TableCalendar(
      locale: 'fr_FR',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
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

  Expanded _buildListeEvents() {
    List<Event> _eventsPourCeJour = _getEventsForDay(_jourSelectionne);

    return Expanded(
      child: ListView.builder(
        itemCount: _eventsPourCeJour.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(_eventsPourCeJour[index].titre),
              subtitle: Text(
                  '${_eventsPourCeJour[index].date?.hour}:${_eventsPourCeJour[index].date?.minute}'
              ),
              onTap: () => _editerEvent(_eventsPourCeJour[index], false),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _supprimerEvent(_eventsPourCeJour[index]),
              ));
        },
      ),
    );
  }

  Padding _buildBoutonsActions() => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
              heroTag: 'ajouter-event',
              tooltip: 'Supprimer tous les événements',
              onPressed: _viderEvents,
              backgroundColor: Colors.red,
              child: const Icon(Icons.delete)),
          FloatingActionButton(
              heroTag: 'vider-events',
              tooltip: 'Ajouter un événement',
              onPressed: _creerNouvelEvent,
              backgroundColor: Colors.green,
              child: const Icon(Icons.add)),
        ],
      ));

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) =>
      setState(() => _jourSelectionne = selectedDay);

  void _onFormatChanged(CalendarFormat format) =>
      setState(() => _calendarFormat = format);

  void _onPageChanged(DateTime focusedDay) => _jourSelectionne = focusedDay;

  List<Event> _eventLoader(DateTime day) => _getEventsForDay(day);

  List<Event> _getEventsForDay(DateTime day) => _getEventsData().getEventsParJour(day);
}
