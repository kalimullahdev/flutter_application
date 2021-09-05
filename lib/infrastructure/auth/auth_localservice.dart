import 'package:flutter_application/models/auth/user_entity.dart';
import 'package:sqflite/sqflite.dart';

class AuthLocalservice {
  final Database _database;

  AuthLocalservice(this._database);

  Future<void> insertUser(User user) async {
    final db = _database;
    await db.insert(
      'user',
      user.toMap(),
    );
  }

  Future<List<User>> users() async {
    final db = _database;

    final List<Map<String, dynamic>> maps = await db.query('user');
    return List.generate(
      maps.length,
      (i) {
        return User(
          id: maps[i]['id'].toString(),
          name: maps[i]['name'].toString(),
          email: maps[i]['email'].toString(),
          password: maps[i]['password'].toString(),
          hobbies: maps[i]['hobbies'].toString(),
          dateOfBirth: maps[i]['dateOfBirth'].toString(),
          programmingLanguage: maps[i]['programmingLanguage'].toString(),
          gender: maps[i]['gender'].toString(),
        );
      },
    );
  }

  Future<void> updateUser(User user) async {
    final db = _database;

    await db.update(
      'user',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<User> getProductById(int id) async {
    final db = _database;
    final List<Map<String, dynamic>> maps =
        await db.query("user", where: "id = ", whereArgs: [id]);
    return User(
      id: maps[0]['id'].toString(),
      name: maps[0]['name'].toString(),
      email: maps[0]['email'].toString(),
      password: maps[0]['password'].toString(),
      hobbies: maps[0]['hobbies'].toString(),
      dateOfBirth: maps[0]['dateOfBirth'].toString(),
      programmingLanguage: maps[0]['programmingLanguage'].toString(),
      gender: maps[0]['gender'].toString(),
    );
    // return result.isNotEmpty ? User.fromMap(result.first) : Null;
  }

  Future<User> getUser(String id) async {
    final db = _database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('Select * FROM user WHERE id = ?', [id]);
    return User(
      id: maps[0]['id'].toString(),
      name: maps[0]['name'].toString(),
      email: maps[0]['email'].toString(),
      password: maps[0]['password'].toString(),
      hobbies: maps[0]['hobbies'].toString(),
      dateOfBirth: maps[0]['dateOfBirth'].toString(),
      programmingLanguage: maps[0]['programmingLanguage'].toString(),
      gender: maps[0]['gender'].toString(),
    );
    // final db = _database;
    // return db.rawQuery('SELECT * FROM user WHERE id=?', [id]);
  }

  Future<void> deleteUser(String id) async {
    final db = _database;

    await db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
