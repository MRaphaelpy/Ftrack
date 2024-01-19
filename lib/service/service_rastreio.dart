import 'dart:convert';

import 'package:frastreio2/general_variables.dart';
import 'package:frastreio2/service/interface_http.dart';
import '../models/objeto_rastreio.dart';

class RastreioService {
  final IHttpClient httpClient;
  final int maxRetries;
  final GlobalVariables globalVariables = GlobalVariables();

  RastreioService({
    required this.httpClient,
    this.maxRetries = 3,
  });

  Future<Pacote?> fetchRastreio(String codigo) async {
    String url =
        'https://api.linketrack.com/track/json?user=${globalVariables.user}&token=${globalVariables.token}&codigo=$codigo';

    for (var i = 0; i < maxRetries; i++) {
      try {
        final response = await httpClient.get(url);

        if (response.statusCode == 200) {
          return Pacote.fromJson(jsonDecode(response.body));
        } else {
          throw Exception(
              'Erro na resposta. Código de status: ${response.statusCode}');
        }
      } catch (e) {
        if (i == maxRetries - 1) {
          throw Exception('Erro: $e');
        }
      }
    }
    return null;
  }
}
