import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUtil {
  static final DatabaseUtil dbProvider = DatabaseUtil();
  static Database? _database;
  static const int _databaseVersion = 2;

  Future<Database> get database async {
    _database ??= await _createDatabase();
    return _database!;
  }

  Future<Database> _createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'todo_app.db');

    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _initDB,
      onUpgrade: _onUpgrade,
    );

    return database;
  }

  Future<void> _onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      if (oldVersion < 2) {
        // Обновление с версии 1 до версии 2, на будущее, если понадобится
        await database.execute('ALTER TABLE tasks ADD COLUMN category TEXT');
      }
      // Добавить другие логики обновления для других версий базы данных
    }
  }

  Future<void> _initDB(Database database, int version) async {
    await database.execute('CREATE TABLE IF NOT EXISTS importanceType ( '
        'id   INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
        'type VARCHAR(10) '
        ')');

    await database.execute('CREATE TABLE IF NOT EXISTS tasks ( '
        'id               VARCHAR(100) PRIMARY KEY NOT NULL, '
        'text             TEXT, '
        'importance       INTEGER REFERENCES importanceType(importance), '
        'deadline         INTEGER, '
        'done             INTEGER, '
        'color            TEXT, '
        'created_at       INTEGER, '
        'changed_at       INTEGER, '
        'last_updated_by  TEXT, '
        'deleted          INTEGER, '
        'category         TEXT '
        ')');
  }
}
