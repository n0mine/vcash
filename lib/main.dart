import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  var database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = const Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertDog(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await dogs()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateDog(fido);

  // Print the updated results.
  print(await dogs()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteDog(fido.id);

  // Print the list of dogs (empty).
  print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

// import 'package:flutter/material.dart';
// import 'package:money_chart/db/db.dart';
// import 'package:money_chart/model/history_notes.dart';

// void main() {
//   // runApp(MyApp());
//   DBProvider.db.insertHistoryNotes(HistoryNotes(0, "data1"));
//   DBProvider.db.insertHistoryNotes(HistoryNotes(1, "data2"));
//   DBProvider.db.insertHistoryNotes(HistoryNotes(2, "data3"));
//   DBProvider.db.getNotes().then((value) {
//     print(value);
//   });
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // #docregion build
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Startup Name Generator',
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//         ),
//       ),
//       // home: MoneyChart(),
//       // routes: {
//       //   SecondScreenInfo.routeName: (context) => const SecondScreenInfo(),
//       // },
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case MoneyChart.routeName:
//             return MaterialPageRoute(builder: (context) => MoneyChart());
//           case SecondScreenInfo.routeName:
//             var money = settings.arguments as int;
//             return MaterialPageRoute(
//                 builder: (context) =>
//                     SecondScreenInfo(balanceState: BalanceState(money)));
//         }
//       },
//     );
//   }
//   // #enddocregion build
// }

// class MoneyChart extends StatefulWidget {
//   const MoneyChart({Key? key}) : super(key: key);
//   static const routeName = '/';

//   @override
//   State<MoneyChart> createState() => _MoneyChartState();
// }

// class _MoneyChartState extends State<MoneyChart> {
//   var _balanceNumber = 0;
//   var myController = TextEditingController();

//   void getValueForMoneyTextField() {
//     _balanceNumber = int.tryParse(myController.text) ?? _balanceNumber;
//     myController.clear();
//     refresh();
//   }

//   refresh() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "MONEY",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: _buildBody(),
//     );
//   }

//   Widget _buildBody() {
//     return Column(
//       children: [
//         TextField(
//           textAlign: TextAlign.center,
//           textAlignVertical: TextAlignVertical.center,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white, width: 0),
//             ),
//             hintText: 'CASH/DAY',
//             hintStyle: TextStyle(fontSize: 40, color: Colors.black),
//           ),
//           // showCursor: false,
//           style: TextStyle(fontSize: 40),
//           controller: myController,
//           onSubmitted: (_) {
//             getValueForMoneyTextField();
//             Navigator.pushNamed(context, SecondScreenInfo.routeName,
//                 arguments: _balanceNumber);
//           },
//         ),
//       ],
//       mainAxisAlignment: MainAxisAlignment.center,
//     );
//   }
// }

// class SecondScreenInfo extends StatefulWidget {
//   SecondScreenInfo({Key? key, required this.balanceState}) : super(key: key);

//   BalanceState balanceState = BalanceState(0);
//   static const routeName = '/secondScreenInfo';

//   @override
//   State<SecondScreenInfo> createState() => _SecondScreenInfoState();
// }

// class _SecondScreenInfoState extends State<SecondScreenInfo> {
//   var textController = TextEditingController();

//   int getValueForExpenseTextField() {
//     var inputExpense = int.tryParse(textController.text) ?? 0;
//     textController.clear();
//     refresh();
//     return inputExpense;
//   }

//   refresh() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final BalanceState balanceState =
//     //     ModalRoute.of(context)!.settings.arguments as BalanceState;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "DAILY",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Flexible(
//             child: dailyDate(),
//             flex: 5,
//           ),
//           Flexible(
//             flex: 50,
//             fit: FlexFit.tight,
//             child: bodyBuild(),
//           ),
//           Flexible(
//             flex: 50,
//             fit: FlexFit.tight,
//             child: enterExpense(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget bodyBuild() {
//     return Row(
//       children: [
//         Column(
//           children: [
//             Text(widget.balanceState.dailyConsumption.toString(),
//                 style: TextStyle(color: Colors.black, fontSize: 40)),
//           ],
//           mainAxisAlignment: MainAxisAlignment.center,
//         ),
//       ],
//       mainAxisAlignment: MainAxisAlignment.center,
//     );
//   }

//   Widget dailyDate() {
//     return Row(
//       children: [
//         Text(
//           'DAY 1',
//           style: TextStyle(
//             color: Colors.red,
//             fontSize: 25,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget enterExpense() {
//     return TextField(
//       textAlign: TextAlign.center,
//       textAlignVertical: TextAlignVertical.center,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white, width: 0),
//         ),
//         hintText: 'input expense',
//         hintStyle: TextStyle(fontSize: 40, color: Colors.black),
//       ),
//       // showCursor: false,
//       style: TextStyle(fontSize: 40),
//       controller: textController,
//       onSubmitted: (_) {
//         var expenseValue = getValueForExpenseTextField();
//         widget.balanceState.dailyConsumption -= expenseValue;
//       },
//     );
//   }
// }

// class BalanceState {
//   int dailyConsumption = 0;
//   int currentMoneyBalance = 0;
//   int advantage = 0;

//   BalanceState(this.dailyConsumption);
// }
