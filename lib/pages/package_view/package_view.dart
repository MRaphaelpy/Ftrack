import 'package:flutter/material.dart';
import 'package:frastreio2/pages/package_view/event_list.dart';
import 'package:frastreio2/pages/package_view/package_local_widget.dart';
import 'package:frastreio2/widgets/custom_erro_alert_dialog.dart';
import 'package:lottie/lottie.dart';
import '../../database/package_json_database_operation.dart';
import '../../database/package_json_db.dart';
import '../../models/objeto_rastreio.dart';
import '../../service/interface_http.dart';
import '../../service/service_rastreio.dart';
import 'package_state.dart';

class PackageView extends StatefulWidget {
  final String codigo;

  const PackageView({
    Key? key,
    required this.codigo,
  }) : super(key: key);

  @override
  _PackageViewState createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView> {
  late PackageState _packageState;
  final RastreioService rastreioService = RastreioService(httpClient: HttpService());
  final DatabaseHelperJson databaseHelper = DatabaseHelperJson.instance;

  int _reloadButtonTapCount = 0;
  DateTime? _lastReloadTime;

  @override
  void initState() {
    super.initState();
    _packageState = PackageState(
      rastreioService: rastreioService,
      onStateChanged: () {
        setState(() {});
      },
    );
    _loadPackageDataFromDatabase(widget.codigo);
  }

  Future<void> _loadPackageDataFromDatabase(String codigo) async {
    try {
      List<Pacote> pacotes = await databaseHelper.getPacotes();

      if (pacotes.isNotEmpty) {

        _packageState.pacote = pacotes.first;
        setState(() {});
      } else {
        await _fetchAndSaveRastreioData(codigo);
      }
    } catch (e) {
      CustomErrorAlertDialog(
        errorMessage: 'Erro ao carregar dados do banco de dados: $e',
      );

    }
  }

  Future<void> _fetchAndSaveRastreioData(String codigo) async {
    DatabaseOperations databaseOperations = DatabaseOperations(
      rastreioService: rastreioService,
      databaseHelper: databaseHelper,
    );

    try {
      await databaseOperations.fetchAndSaveRastreio(codigo);
    } catch (e) {
      CustomErrorAlertDialog(
        errorMessage: 'Erro ao buscar ou salvar rastreio: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pacote'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _handleReloadButtonTap();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Future.delayed(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 200,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Container(
                  height: 200,
                  child: Center(
                    child: Text('Erro: ${snapshot.error}'),
                  ),
                );
              } else if (_packageState.pacote == null) {
                return Container(
                  height: 200,
                  child: Center(
                    child: Lottie.asset("assets/images/empty.json"),
                  ),
                );
              } else {
                var primeiroEvento = _packageState.pacote!.eventos.isNotEmpty
                    ? _packageState.pacote!.eventos[0]
                    : null;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    elevation: 4,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: PackageLocalWidget(local: primeiroEvento?.local ?? ''),
                  ),
                );
              }
            },
          ),

          Expanded(
            child: FutureBuilder(
              future: Future.delayed(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro: ${snapshot.error}'),
                  );
                } else if (_packageState.pacote == null ||
                    _packageState.pacote?.eventos.isEmpty == true) {

                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset("assets/images/empty.json"),
                        const Text(
                          'Nenhum evento encontrado',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: EventList(_packageState),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleReloadButtonTap() {
    final DateTime now = DateTime.now();


    if (_lastReloadTime == null ||
        now.difference(_lastReloadTime!) >= Duration(minutes: 2)) {

      _reloadButtonTapCount = 0;
    }


    _reloadButtonTapCount++;

    if (_reloadButtonTapCount <= 2) {

      _lastReloadTime = now;
      _fetchAndSaveRastreioData(widget.codigo);
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Limite de recarga atingido. Aguarde 2 minutos.'),
        ),
      );
    }
  }
}
