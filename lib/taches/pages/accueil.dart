import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepadd/global/methods/recharge_facile.dart';
import 'package:notepadd/global/methods/appbars.dart';

import 'package:notepadd/taches/models/tache.dart';
import 'package:notepadd/taches/models/taches_data.dart';

class TachesHome extends StatefulWidget {
  const TachesHome({Key? key}) : super(key: key);

  @override
  State<TachesHome> createState() => _TachesHomeState();
}

class _TachesHomeState extends StateRechargeFacile<TachesHome> {
  @override
  void initStateCustom() => _initialiserTaches();

  void fairePuisRechargerTaches(void Function() action) => fairePuisRecharger(
      action, methodeRechargeElement: () => _chargerTaches());

  // Back-end
  List<Tache> _tachesAAfficher = [];
  String _titreNouvelleTache = '';
  final TextEditingController _controllerNouvelleTache = TextEditingController();
  final TextEditingController _controllerRechercheTaches = TextEditingController();


  TachesData _getTachesData() => Provider.of<TachesData>(context, listen: false);

  List<Tache> _getTaches() {
    List<Tache> liste = _getTachesData().getTaches();
    liste.sort((a, b) => a.priorite.compareTo(b.priorite));
    return liste;
  }

  void _initialiserTaches() {
    _getTachesData().initialiserTaches();
    _chargerTaches();
    _controllerNouvelleTache.addListener(() =>_titreNouvelleTache = _controllerNouvelleTache.text);
  }

  void _chargerTaches() => _tachesAAfficher = _getTaches();

  Tache _creerNouvelleTache(String? titre) => _getTachesData().creerNouvelleTache(titre);

  void _supprimerTache(Tache tache) => fairePuisRechargerTaches(() => _getTachesData().remove(tache));

  void _viderTaches() => fairePuisRechargerTaches(() => _getTachesData().clear());

  void _mettreTacheEnFait(Tache tache) => fairePuisRechargerTaches(() {
        tache.estFait ^= true;
        _getTachesData().update(tache);
      });

  void _mettreTacheEnImportant(Tache tache) => fairePuisRechargerTaches(() {
        tache.estImportant ^= true;
        _getTachesData().update(tache);
      });

  void _sauvegarderTache() => fairePuisRechargerTaches(() {
        if (_titreNouvelleTache.isEmpty) return;
        Tache nouvelleTache = _creerNouvelleTache(_titreNouvelleTache);
        _getTachesData().add(nouvelleTache);
        _controllerNouvelleTache.clear();
        _controllerRechercheTaches.clear();
      });

  void _rechercherTaches(String titre) => fairePuisRecharger(() => _tachesAAfficher = _getTachesData().rechercherTaches(titre));

  // ----------------------------
  // UI

  @override
  Scaffold buildScaffold() => Scaffold(
        appBar: buildAppBar(context, 'Tâches'),
        body: Column(
          children: [
            _buildMenuRechercheTaches(),
            Expanded(child: _buildListeTaches()),
            _buildMenuGestionTaches(),
          ],
        ));

  ListView _buildListeTaches() => ListView.builder(
            itemCount: _tachesAAfficher.length,
            itemBuilder: (context, index) {
              Tache tache = _tachesAAfficher[index];
              return Dismissible(
                key: Key(tache.priorite.toString()),
                onDismissed: (direction) => _supprimerTache(tache),
                child: _buildCarteTache(tache));
            });

  Row _buildMenuRechercheTaches() => Row(
        children: [
          Expanded(
              child: Container(
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                child: _buildFormRechercheTache(),
              ))
        ]);

  Row _buildMenuGestionTaches() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildFormCreationTache()),
          _buildMenuActions()
        ]);

  Row _buildMenuActions() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _buildBoutonAjoutTache()
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _buildBoutonViderTaches()
            )
          ]);

  ListTile _buildCarteTache(Tache tache) => ListTile(
      title: Text(
          tache.titre,
          style: tache.estFait ? const TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ) : null),
      leading: IconButton(
        onPressed: () => _mettreTacheEnImportant(tache),
        icon: tache.estImportant
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () => _mettreTacheEnFait(tache),
              icon: tache.estFait
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank)),
          IconButton(
            onPressed: () => _supprimerTache(tache),
            icon: const Icon(Icons.delete),
          )
        ],
      ));

  TextField _buildFormRechercheTache() => TextField(
        decoration: const InputDecoration(
          hintText: 'Rechercher une tâche',
          prefixIcon: Icon(Icons.search),
          prefixIconConstraints: BoxConstraints(minWidth: 50)
        ),
        controller: _controllerRechercheTaches,
        textInputAction: TextInputAction.done,
        onChanged: (value) => _rechercherTaches(value),
      );

  Container _buildFormCreationTache() => Container(
        margin: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Créer une tâche',
            prefixIcon: Icon(Icons.add),
            prefixIconConstraints: BoxConstraints(minWidth: 25)
          ),
          controller: _controllerNouvelleTache,
          textInputAction: TextInputAction.done,
          onSubmitted: (value) => _sauvegarderTache(),
        ));

  FloatingActionButton _buildBoutonAjoutTache() => buildBoutonAction(
      heroTag: 'btnAjoutTache',
      tooltip: 'Ajouter une tâche',
      color: Colors.green,
      onPressed: _sauvegarderTache,
      icon: const Icon(Icons.add));

  FloatingActionButton _buildBoutonViderTaches() => buildBoutonAction(
      heroTag: 'btnViderTaches',
      tooltip: 'Vider les tâches',
      color: Colors.red,
      onPressed: _viderTaches,
      icon: const Icon(Icons.delete_forever));
}
