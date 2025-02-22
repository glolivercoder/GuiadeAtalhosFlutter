import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/git_credentials.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'actionworkflow.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE git_credentials (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            token TEXT NOT NULL,
            client_id TEXT,
            client_secret TEXT,
            api_url TEXT
          )
        ''');
      },
    );
  }

  static Future<List<GitCredentials>> getGitCredentials() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('git_credentials');
    return List.generate(maps.length, (i) => GitCredentials.fromMap(maps[i]));
  }

  static Future<int> addGitCredentials(GitCredentials credentials) async {
    final db = await database;
    return await db.insert('git_credentials', credentials.toMap());
  }

  static Future<int> updateGitCredentials(GitCredentials credentials) async {
    final db = await database;
    return await db.update(
      'git_credentials',
      credentials.toMap(),
      where: 'id = ?',
      whereArgs: [credentials.id],
    );
  }

  static Future<int> deleteGitCredentials(int id) async {
    final db = await database;
    return await db.delete(
      'git_credentials',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}