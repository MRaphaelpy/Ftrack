import 'package:flutter/material.dart';
import 'package:frastreio2/appbar/app_bar_custom.dart';
import 'package:frastreio2/pages/inicial_page/floating_action_button/custom_floating_action_button.dart';
import 'package:lottie/lottie.dart';
import '../../database/db.dart';
import 'inicial_page.dart';
import 'package_list/edit_package_dialog.dart';
import 'package_list/package_widget.dart';

class InicialPageState extends State<InicialPage> {
  List<PackageWidget> packages = [];
  late DB _db;

  @override
  void initState() {
    super.initState();
    _db = DB.instance;
    _loadPackages();
  }

  void _loadPackages() async {
    final pacotes = await _db.getPacotes();
    setState(() {
      packages = pacotes
          .map((package) => PackageWidget(
                nome: package['nome'],
                codigo: package['codigo'],
                onEdit: () => _editPackage(
                    package['id'], package['nome'], package['codigo']),
                onDelete: () => _deletePackage(package['id']),
              ))
          .toList();
    });
  }

  void _addPackage(String nome, String codigo) async {
    if (packages.any((package) => package.codigo == codigo)) {
      return;
    }

    final newPackageId = await _db.insertPacote(nome, codigo);
    _loadPackages();
  }

  void _editPackage(int id, String oldNome, String oldCodigo) {
    showDialog(
      context: context,
      builder: (BuildContext context) => EditPackageDialog(
        oldNome: oldNome,
        oldCodigo: oldCodigo,
        onEdit: (newNome, newCodigo) async {
          await _db.updatePacote(id, newNome, newCodigo);
          _loadPackages();
        },
      ),
    );
  }

  void _deletePackage(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza de que deseja excluir este pacote?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _db.deletePacote(id);
                _loadPackages();
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const Drawer(),
      appBar: const AppBarCustom(),
      body: packages.isEmpty
          ? Center(
              child: Lottie.asset(
                'assets/images/vazio.json',
                width: 300,
                height: 300,
              ),
            )
          : ListView.builder(
              itemCount: packages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: packages[index],
                );
              },
            ),
      floatingActionButton:
          CustomFloatingActionButton(onAddPackage: _addPackage),
    );
  }
}
