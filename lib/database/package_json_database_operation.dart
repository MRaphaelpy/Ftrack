import 'package:frastreio2/database/package_json_db.dart';
import 'package:frastreio2/widgets/custom_erro_alert_dialog.dart';
import '../models/objeto_rastreio.dart';
import '../service/service_rastreio.dart';

class DatabaseOperations {
  final RastreioService rastreioService;
  final DatabaseHelperJson databaseHelper;

  DatabaseOperations({
    required this.rastreioService,
    required this.databaseHelper,
  });

  Future<Pacote?> fetchAndSaveRastreio(String codigo) async {
    try {
      Pacote? pacote = await rastreioService.fetchRastreio(codigo);

      if (pacote != null) {
        await databaseHelper.insertPacote(pacote);
        return pacote;
      }
    } catch (e) {
      CustomErrorAlertDialog(
        errorMessage: "Erro ao buscar pacote ${e.toString()}.",
      );
    }

    return null;
  }
}
