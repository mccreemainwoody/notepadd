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
    TextEditingController dateEventControlleur = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            title: Text(widget.estNouvelEvent ? 'Nouvel événement' : 'Modifier l\'événement'),
            actions: [
              _buildBoutonSauvegarder(),
              !widget.estNouvelEvent
                  ? _buildBoutonSupprimer()
                  : Container(),
            ]),
        body: Column(
          children: [
            _buildChampTitre(),
            _buildChampDateHeure(context, dateEventControlleur)
          ],
        ));
  }

  IconButton _buildBoutonSupprimer() => IconButton(
      onPressed: supprimerEvent,
      icon: const Icon(Icons.delete)
  );

  IconButton _buildBoutonSauvegarder() => IconButton(
      onPressed: sauvegarderEvent,
      icon: const Icon(Icons.save)
  );

  Padding _buildChampTitre() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          decoration: const InputDecoration(
              labelText: 'Titre', icon: Icon(Icons.title)),
          controller: TextEditingController(text: getEvent().titre),
          onChanged: (value) => getEvent().titre = value));


  Padding _buildChampDateHeure(
      BuildContext context, TextEditingController controller) {
    DateTime dateActuelle = getEvent().date ?? DateTime.now();
    if (!widget.estNouvelEvent) controller.text = dateActuelle.toString();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
              labelText: 'Date de l\'événement',
              icon: Icon(Icons.calendar_month)),
          onTap: () async {
            DateTime? date = await showDatePicker(
                context: context,
                initialDate: dateActuelle,
                firstDate: DateTime(2000, 1, 1),
                lastDate: DateTime.now().add(const Duration(days: 365 * 10))
            );

            if (date == null) return;

            TimeOfDay? heure = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now()
            );

            getEvent().date = heure != null
                ? DateTime(date.year, date.month, date.day, heure.hour, heure.minute)
                : date;

            controller.text = getEvent().date.toString();
          },
        ));
  }
}
