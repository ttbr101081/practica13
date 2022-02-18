import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE preguntas(
        id INTEGER PRIMARY KEY NOT NULL,
        pregunta TEXT,
        r1 TEXT,
        r2 TEXT,
        r3 TEXT,
        rc INTEGER
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'quiz.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static createItem() async {
    final db = await SQLHelper.db();

    final data = {'id': 1, 'pregunta': '¿Quien escribio la odisiea?', 'r1': 'Shakespeare', 'r2': 'Homero', 'r3': 'Cervantes', 'rc': 2};
    final id = await db.insert('preguntas', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    final data1 =  {'id': 2, 'pregunta': '¿Dónde originaron los juegos olímpicos?', 'r1': 'Grecia', 'r2': 'Roma', 'r3': 'Tokio', 'rc': 1};
    final id1 = await db.insert('preguntas', data1,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    final data2 = {'id': 3, 'pregunta': '¿Qué tipo de animal es la ballena?', 'r1': 'Pez', 'r2': 'Reptil', 'r3': 'Mamífero', 'rc': 3};
    final id2 = await db.insert('preguntas', data2,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    final data3 = {'id': 4, 'pregunta': '¿Cuándo acabó la II Guerra Mundial?', 'r1': '1940', 'r2': '1830', 'r3': '1945', 'rc': 3};
    final id3 = await db.insert('preguntas', data3,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    final data4 = {'id': 5, 'pregunta': '¿Cuál es el primero de la lista de los números primos?', 'r1': '8', 'r2': '2', 'r3': '10', 'rc': 2};
    final id4 = await db.insert('preguntas', data4,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('preguntas', orderBy: "id");
  }

}
