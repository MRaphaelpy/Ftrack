import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/objeto_rastreio.dart';

class DatabaseHelperJson {
  DatabaseHelperJson._();
  static final DatabaseHelperJson instance = DatabaseHelperJson._();

  static Database? _database;
  static const String pacoteTable = 'pacotes';
  static const String eventoTable = 'eventos';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'packagejson.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $pacoteTable (
            id INTEGER PRIMARY KEY,
            codigo TEXT,
            servico TEXT,
            host TEXT,
            quantidade INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE $eventoTable (
            id INTEGER PRIMARY KEY,
            pacoteId INTEGER,
            data TEXT,
            hora TEXT,
            local TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertPacote(Pacote pacote) async {
    final Database db = await database;

    int pacoteId = await db.insert(
      pacoteTable,
      {
        'codigo': pacote.codigo,
        'servico': pacote.servico,
        'host': pacote.host,
        'quantidade': pacote.quantidade,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Inserir informações dos Eventos associados ao Pacote
    for (Evento evento in pacote.eventos) {
      await db.insert(
        eventoTable,
        {
          'pacoteId': pacoteId,
          'data': evento.data,
          'hora': evento.hora,
          'local': evento.local,
          'status': evento.status,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Pacote>> getPacotes() async {
    final Database db = await database;

    List<Map<String, dynamic>> pacoteMaps = await db.query(pacoteTable);
    List<Pacote> pacotes = [];

    for (Map<String, dynamic> pacoteMap in pacoteMaps) {
      int pacoteId = pacoteMap['id'];
      List<Map<String, dynamic>> eventoMaps = await db.query(
        eventoTable,
        where: 'pacoteId = ?',
        whereArgs: [pacoteId],
      );

      List<Evento> eventos = eventoMaps.map((e) => Evento.fromJson(e)).toList();

      Pacote pacote = Pacote(
        codigo: pacoteMap['codigo'],
        servico: pacoteMap['servico'],
        host: pacoteMap['host'],
        quantidade: pacoteMap['quantidade'],
        eventos: eventos,
      );

      pacotes.add(pacote);
    }

    return pacotes;
  }
}
