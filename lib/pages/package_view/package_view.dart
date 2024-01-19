import 'package:flutter/material.dart';
import 'package:frastreio2/pages/package_view/event_list.dart';
import 'package:frastreio2/pages/package_view/package_local_widget.dart';
import 'package:lottie/lottie.dart';
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
  // ignore: library_private_types_in_public_api
  _PackageViewState createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView> {
  late PackageState _packageState;
  final RastreioService rastreioService =
      RastreioService(httpClient: HttpService());

  @override
  void initState() {
    super.initState();
    _packageState = PackageState(
      rastreioService: rastreioService,
      onStateChanged: () {
        setState(() {});
      },
    );

    _getTestPackageData().then((testPackage) {
      if (testPackage != null) {
        _packageState.pacote = testPackage;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pacote'),
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
                )
                ;
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


  Future<Pacote?> _getTestPackageData() async {
    return Pacote.fromJson({
      "codigo": "LX002249507BR",
      "servico": "PAC - Encomenda Econômica",
      "host": "dw",
      "quantidade": 12,
      "eventos": [
        {
          "data": "24/10/2019",
          "hora": "10:40",
          "local": "CURITIBA/PR",
          "status": "Devolução autorizada pela Receita Federeul",
          "subStatus": ["Registrado por CENTRO INTERNACIONAL PR - CURITIBA/PR"]
        },
        {
          "data": "11/09/2019",
          "hora": "00:00",
          "local": "CURITIBA/PR",
          "status": "Pagamento não efetuado no prazo",
          "subStatus": ["Objeto em análise de destinação"]
        },
        {
          "data": "11/09/2019",
          "hora": "00:00",
          "local": "CURITIBA/PR",
          "status": "Pagamento não efetuado no prazo",
          "subStatus": ["Objeto em análise de destinação"]
        },
        {
          "data": "11/09/2019",
          "hora": "00:00",
          "local": "CURITIBA/PR",
          "status": "Pagamento não efetuado no prazo",
          "subStatus": ["Objeto em análise de destinação"]
        },{
          "data": "11/09/2019",
          "hora": "00:00",
          "local": "CURITIBA/PR",
          "status": "Pagamento não efetuado no prazo",
          "subStatus": ["Objeto em análise de destinação"]
        },{
          "data": "11/09/2019",
          "hora": "00:00",
          "local": "CURITIBA/PR",
          "status": "Pagamento não efetuado no prazo",
          "subStatus": ["Objeto em análise de destinação"]
        },{
          "data": "11/09/2019",
          "hora": "00:00",
          "local": "CURITIBA/PR",
          "status": "Pagamento não efetuado no prazo",
          "subStatus": ["Objeto em análise de destinação"]
        },{
          "data": "11/09/2019",
          "hora": "00:00",
          "local": "CURITIBA/PR",
          "status": "Pagamento não efetuado no prazo",
          "subStatus": ["Objeto em análise de destinação"]
        },
        // Adicione mais eventos conforme necessário
      ],
    });
  }
}
