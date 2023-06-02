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
  @override
  Widget build(BuildContext context) => _buildScaffold(context);

  void faireEtQuitter(Function action) {
    action();
    Navigator.pop(context);
  }

  // Back-end
  final TextEditingController _dateEventControlleur = TextEditingController();
  Event getEvent() => widget.event;
  EventsData getEventsData() => Provider.of<EventsData>(context, listen: false);

  void ajouterEvent() => getEventsData().add(getEvent());

  void modifierEvent() => getEventsData().update(getEvent());

  void supprimerEvent() => faireEtQuitter(() => getEventsData().remove(getEvent()));

  void sauvegarderEvent() => faireEtQuitter(() => widget.estNouvelEvent ? ajouterEvent() : modifierEvent());

  // --------------------------
  // UI

  Scaffold _buildScaffold(BuildContext context) => Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: _buildChampTitre()),
          Padding(padding: const EdgeInsets.all(8.0), child: _buildChampDateHeure(context))
        ],
      ));

  AppBar _buildAppBar() => AppBar(
        title: Text(widget.estNouvelEvent ? 'Nouvel événement' : 'Modifier l\'événement'),
        actions: [
          _buildBoutonSauvegarder(),
          !widget.estNouvelEvent
              ? _buildBoutonSupprimer()
              : Container(),
        ]);

  IconButton _buildBoutonSauvegarder() => IconButton(
      onPressed: sauvegarderEvent,
      icon: const Icon(Icons.save)
  );

  IconButton _buildBoutonSupprimer() => IconButton(
      onPressed: supprimerEvent,
      icon: const Icon(Icons.delete)
  );

  TextField _buildChampTitre() => TextField(
      decoration: const InputDecoration(labelText: 'Titre', icon: Icon(Icons.title)),
      controller: TextEditingController(text: getEvent().titre),
      onChanged: (value) => getEvent().titre = value);

  TextField _buildChampDateHeure(BuildContext context) {
    DateTime dateActuelle = getEvent().date ?? DateTime.now();
    if (!widget.estNouvelEvent) _dateEventControlleur.text = dateActuelle.toString();
    return TextField(
          controller: _dateEventControlleur,
          decoration: const InputDecoration(labelText: 'Date de l\'événement', icon: Icon(Icons.calendar_month)),
          onTap: () async {
            DateTime? date = await showDatePicker(
                context: context,
                initialDate: dateActuelle,
                firstDate: DateTime(2000, 1, 1),
                lastDate: DateTime.now().add(const Duration(days: 365 * 10))
            );

            if (date == null) return;

            TimeOfDay? heure = await showTimePicker(context: context, initialTime: TimeOfDay.now());

            getEvent().date = heure != null
                ? DateTime(date.year, date.month, date.day, heure.hour, heure.minute)
                : date;

            _dateEventControlleur.text = getEvent().date.toString();
          },
        );
  }
}
