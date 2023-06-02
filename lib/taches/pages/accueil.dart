import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepadd/taches/models/tache.dart';
import 'package:notepadd/taches/models/taches_data.dart';


class TachesHome extends StatefulWidget {
  const TachesHome({Key? key}) : super(key: key);

  @override
  State<TachesHome> createState() => _TachesHomeState();
}

class _TachesHomeState extends State<TachesHome> {
  @override
  void initState() {
    super.initState();
    _getTachesData().initialiserTaches();
  }

  @override
  Widget build(BuildContext context) =>
      Consumer(builder: (context, value, child) => _buildScaffold());

  // Back-end
  TachesData _getTachesData() => Provider.of<TachesData>(context, listen: false);

  void _creerNouvelleTache() {}

  void _editerTache() {}

  void _supprimerTache() {}

  void _viderTaches() {}

  void _mettreTacheEnImportant() {}

  // ----------------------------
  // UI

  Scaffold _buildScaffold() => Scaffold(
      appBar: AppBar(
        title: const Text('Tâches'),
      ),
      body: Column(
        children: [
          _buildListeTaches(),
          _buildMenuTaches(),
        ],
      ),
    );

  Row _buildListeTaches() => Row();

  Row _buildMenuTaches() => Row();
}
