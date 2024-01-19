import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database? _database;

  bool? _isDarkMode;
  bool? _isAnimationPlaying;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print('Initializing the database');
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, 'database.db');


    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
    //  onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS pacotes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        codigo TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS eventos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        codigo TEXT,
        pacote_id INTEGER,
        FOREIGN KEY(pacote_id) REFERENCES pacotes(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS settings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        is_dark_mode INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS animacao(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        is_playing INTEGER
      )
    ''');
  }



  Future<List<Map<String, dynamic>>> getPacotes() async {
    final db = await database;
    return await db.query('pacotes');
  }

  Future<int> insertPacote(String nome, String codigo) async {
    final db = await database;
    return await db.insert(
      'pacotes',
      {'nome': nome, 'codigo': codigo},
    );
  }

  Future<int> updatePacote(int id, String nome, String codigo) async {
    final db = await database;
    return await db.update(
      'pacotes',
      {'nome': nome, 'codigo': codigo},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePacote(int id) async {
    final db = await database;
    return await db.delete(
      'pacotes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool?> getThemeMode() async {
    if (_isDarkMode != null) return _isDarkMode;

    final db = await database;
    final result =
    await db.query('settings', columns: ['is_dark_mode'], limit: 1);

    if (result.isNotEmpty) {
      _isDarkMode = result.first['is_dark_mode'] == 1;
    }

    return _isDarkMode;
  }

  Future<bool?> getAnimationState() async {
    if (_isAnimationPlaying != null) return _isAnimationPlaying;

    final db = await database;
    final result = await db.query('animacao', columns: ['is_playing'], limit: 1);

    if (result.isNotEmpty) {
      _isAnimationPlaying = result.first['is_playing'] == 1;
    }

    print('Animation state retrieved: $_isAnimationPlaying');
    return _isAnimationPlaying;
  }

  Future<void> setThemeMode(bool isDarkMode) async {
    final db = await database;
    await db.update(
      'settings',
      {'is_dark_mode': isDarkMode ? 1 : 0},
    );
  }

  Future<void> setAnimationState(bool isPlaying) async {
    try {
      final db = await database;
      await db.update(
        'animacao',
        {'is_playing': isPlaying ? 1 : 0},
      );
    } catch (e) {
      print('Error saving animation state: $e');
    }

    print('Animation state saved: $isPlaying');
  }
}