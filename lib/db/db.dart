// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DBcSQL {
//   DBcSQL._();

//   var database = await openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'doggie_database.db'),
//     // When the database is first created, create a table to store dogs.
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );

//   // Define a function that inserts dogs into the database
//   Future<void> insertDog(Dog dog) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the Dog into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same dog is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'dogs',
//       dog.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // A method that retrieves all the dogs from the dogs table.
//   Future<List<Dog>> dogs() async {
//     // Get a reference to the database.
//     final db = await database;

//     // Query the table for all The Dogs.
//     final List<Map<String, dynamic>> maps = await db.query('dogs');

//     // Convert the List<Map<String, dynamic> into a List<Dog>.
//     return List.generate(maps.length, (i) {
//       return Dog(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         age: maps[i]['age'],
//       );
//     });
//   }

//   Future<void> updateDog(Dog dog) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Update the given Dog.
//     await db.update(
//       'dogs',
//       dog.toMap(),
//       // Ensure that the Dog has a matching id.
//       where: 'id = ?',
//       // Pass the Dog's id as a whereArg to prevent SQL injection.
//       whereArgs: [dog.id],
//     );
//   }

//   Future<void> deleteDog(int id) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Remove the Dog from the database.
//     await db.delete(
//       'dogs',
//       // Use a `where` clause to delete a specific dog.
//       where: 'id = ?',
//       // Pass the Dog's id as a whereArg to prevent SQL injection.
//       whereArgs: [id],
//     );
//   }
// }
// // import 'dart:io';
// // import 'package:path/path.dart';
// // import 'package:sqflite/sqflite.dart';
// // import 'package:sqflite/sqlite_api.dart';
// // import 'package:money_chart/model/history_notes.dart';

// // class DBProvider {
// //   DBProvider._();
// //   static final DBProvider db = DBProvider._();

// //   static late Database _database;

// //   String historyTable = 'History';
// //   String columnId = 'id';
// //   String columnName = 'data';

// //   Future<Database> get database async {
// //     if (_database != null) return _database;

// //   final _database = openDatabase(
// //       join(await getDatabasesPath() + 'historyNotes.db'),
// //       version: 1,
// //       onCreate: (db, version)  {
// //         return db.execute('CREATE TABLE $historyTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)',);
// //         },
// //     );
// //     return _database;
// //   }

// //   // Student
// //   // Id | Name
// //   // 0    ..
// //   // 1    ..

// //   // READ
// //   Future<List<HistoryNotes>> getNotes() async {
// //     Database db = await this.database;
// //     final List<Map<String, dynamic>> notesMapList =
// //         await db.query(historyTable);
// //     final List<HistoryNotes> notesList = [];
// //     notesMapList.forEach((notesMap) {
// //       notesList.add(HistoryNotes.fromMap(notesMap));
// //     });

// //     return notesList;
// //   }

// //   //  INSERT
// //   Future<HistoryNotes> insertHistoryNotes(HistoryNotes note) async {
// //     Database db = await this.database;
// //     note.id = await db.insert(historyTable, note.toMap());
// //     return note;
// //   }

// //   // // UPDATE
// //   // Future<int> updateStudent(Student student) async {
// //   //   Database db = await this.database;
// //   //   return await db.update(
// //   //     historyTable,
// //   //     student.toMap(),
// //   //     where: '$columnId = ?',
// //   //     whereArgs: [student.id],
// //   //   );
// //   // }

// //   // // DELETE
// //   // Future<int> deleteStudent(int? id) async {
// //   //   Database db = await this.database;
// //   //   return await db.delete(
// //   //     historyTable,
// //   //     where: '$columnId = ?',
// //   //     whereArgs: [id],
// //   //   );
// //   // }
// // }
