import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> openDatabaseInstance() async {
    return openDatabase(
      join(await getDatabasesPath(), 'freeclassrooms.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, note TEXT, modif TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertNote(Map<String, dynamic> noteData) async {
    final db = await openDatabaseInstance();
    await db.insert('notes', noteData,
        conflictAlgorithm: ConflictAlgorithm.replace);
    await db.close();
  }

  static Future<void> updateNote(Map<String, dynamic> noteData) async {
    final db = await openDatabaseInstance();
    await db.update('notes', noteData,
        where: 'id = ? ', whereArgs: [noteData['id']]);
    await db.close();
  }

  static Future<List<Map<String, Object?>>> read() async {
    final db = await openDatabaseInstance();
    return db.query('notes');
  }

  static Future<void> delete(int id) async {
    final db = await openDatabaseInstance();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // Other database operations can be added similarly
}
/*
class Note {
  final int id;
  final String note;
  final String modif;
  final String nom;
  const Note(
      {required this.id,
      required this.note,
      required this.modif,
      required this.nom});
  @override
  String toString() {
    return "id : $id, nom : $nom ,note: $note, dernire modification: $modif";
  }
}
*/
