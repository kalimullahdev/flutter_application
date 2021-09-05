import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteDatabase {
  late Database _instance;
  Database get instance => _instance;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    if (_hasBeenInitialized) return;
    _hasBeenInitialized = true;

    final dbDirectory = await getApplicationDocumentsDirectory();
    dbDirectory.create(recursive: true);
    final dbPath = join(dbDirectory.path, 'sqflite_database.db');
    _instance = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE user (id TEXT PRIMARY KEY, name TEXT, email TEXT, password TEXT, hobbies TEXT ,dateOfBirth TEXT, programmingLanguage TEXT,  gender TEXT)');
      },
    );
  }
}
