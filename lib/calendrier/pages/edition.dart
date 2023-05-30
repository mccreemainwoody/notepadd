import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:notepadd/calendrier/models/event.dart';
import 'package:notepadd/calendrier/models/event_data.dart';

class EditionEventPage extends StatefulWidget {
  final Event event;
  final bool estNouvelEvent;

  const EditionEventPage(this.event, this.estNouvelEvent, {Key? key}) : super(key: key);

  @override
  State<EditionEventPage> createState() => _EditionEventPageState();
}

class _EditionEventPageState extends State<EditionEventPage> {
  Event getEvent() => widget.event;
  EventsData getEventsData() => Provider.of<EventsData>(context, listen: false);

  void ajouterEvent() => getEventsData().add(getEvent());

  void modifierEvent() => getEventsData().update(getEvent());

  void supprimerEvent() => getEventsData().remove(getEvent());

  void sauvegarderEvent() {
    widget.estNouvelEvent ? ajouterEvent() : modifierEvent();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.estNouvelEvent ? 'Nouvel événement' : 'Modifier l\'événement'),
            actions: [
              IconButton(
                  onPressed: sauvegarderEvent,
                  icon: const Icon(Icons.save)
              ),
              !widget.estNouvelEvent ? IconButton(
                  onPressed: supprimerEvent,
                  icon: const Icon(Icons.delete)
              ) : Container(),
            ]
        ),
        body: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Titre'),
              controller: TextEditingController(text: getEvent().titre),
              onChanged: (value) => getEvent().titre = value,
            ),
            InputDatePickerFormField(
              initialDate: getEvent().date ?? DateTime.now(),
              firstDate: DateTime(2000,1,1),
              lastDate: DateTime.now()..add(const Duration(days: 365*10)),
              onDateSubmitted: (value) => getEvent().date = value,
              keyboardType: TextInputType.datetime,
            ),
          ],
        )
    );
  }
}
