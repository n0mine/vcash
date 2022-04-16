import 'dart:async';

import 'package:money_chart/model/history_notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class DBProvider {
  DBProvider._();
  static DBProvider db = DBProvider._();
  static late Database _database;
  String tableName = 'historyNotes';

  Future<Database> get database async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'historyNotes.db'),
      onCreate: (db, version) {
        db.execute('DROP TABLE IF EXISTS $tableName');
        db.execute(
            'CREATE TABLE $tableName(datetime INTEGER PRIMARY KEY, spendAmount INTEGER, spendNote TEXT)');
      },
      version: 1,
    );
    return _database;
  }

  Future<void> insertHistoryNote(HistoryNotes note) async {
    Database db = await this.database;
    await db.insert(tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<HistoryNotes>> getHistoryNotes(int key) async {
    Database db = await this.database;
    List<Map<String, dynamic>> maps =
        await db.query(tableName, where: 'datetime = ?', whereArgs: [key]);
    return List.generate(maps.length, (i) {
      return HistoryNotes(
        maps[i]['datetime'],
        maps[i]['spendAmount'],
        maps[i]['spendNote'],
      );
    });
  }

  Future<int> removeHistoryNote(int key) async {
    Database db = await this.database;
    return await db.delete(tableName, where: 'datetime = ?', whereArgs: [key]);
  }
}
