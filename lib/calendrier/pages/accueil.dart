import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/event.dart';

class CalendrierHome extends StatefulWidget {
  const CalendrierHome({Key? key}) : super(key: key);

  @override
  State<CalendrierHome> createState() => _CalendrierHomeState();
}

class _CalendrierHomeState extends State<CalendrierHome> {
  final DateTime _today = DateTime.now();
  DateTime _jourSelectionne = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final Map<DateTime, List<Event>> _events = {
    DateTime.utc(2023, 05, 16): [
      Event('Event 1'),
      Event('Event 2'),
      Event('Event 3'),
    ],
    DateTime.utc(2023, 05, 17): [
      Event('Event A'),
      Event('Event B'),
      Event('Event C'),
    ],
    DateTime.utc(2023, 05, 18): [
      Event('Event X'),
      Event('Event Y'),
      Event('Event Z'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendrier'),
        ),
        body: TableCalendar(
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
        )
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) => setState(() {
      _jourSelectionne = selectedDay;
    });

  void _onFormatChanged(CalendarFormat format) => setState(() {
      _calendarFormat = format;
    });

  void _onPageChanged(DateTime focusedDay) => _jourSelectionne = focusedDay;

  List<Event> _eventLoader(DateTime day) {
    return _getEventsForDay(day);
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }
}
