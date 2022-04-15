import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_chart/db/db.dart';
import 'package:money_chart/model/history_notes.dart';
import 'package:money_chart/model/balance_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      // home: MoneyChart(),
      // routes: {
      //   SecondScreenInfo.routeName: (context) => const SecondScreenInfo(),
      // },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case MoneyChart.routeName:
            return MaterialPageRoute(builder: (context) => MoneyChart());
          case SecondScreenInfo.routeName:
            var money = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) =>
                    SecondScreenInfo(balanceState: BalanceState(money)));
        }
      },
    );
  }
}

class MoneyChart extends StatefulWidget {
  const MoneyChart({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<MoneyChart> createState() => _MoneyChartState();
}

class _MoneyChartState extends State<MoneyChart> {
  var _balanceNumber = 0;
  var myController = TextEditingController();

  void getValueForMoneyTextField() {
    _balanceNumber = int.tryParse(myController.text) ?? _balanceNumber;
    myController.clear();
    refresh();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MONEY",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        TextField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0),
            ),
            hintText: 'CASH/DAY',
            hintStyle: TextStyle(fontSize: 40, color: Colors.black),
          ),
          // showCursor: false,
          style: TextStyle(fontSize: 40),
          controller: myController,
          onSubmitted: (_) {
            getValueForMoneyTextField();
            Navigator.pushNamed(context, SecondScreenInfo.routeName,
                arguments: _balanceNumber);
          },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class SecondScreenInfo extends StatefulWidget {
  SecondScreenInfo({Key? key, required this.balanceState}) : super(key: key);

  BalanceState balanceState = BalanceState(0);
  static const routeName = '/secondScreenInfo';

  @override
  State<SecondScreenInfo> createState() => _SecondScreenInfoState();
}

class _SecondScreenInfoState extends State<SecondScreenInfo> {
  var textController = TextEditingController();

  int getValueForExpenseTextField() {
    var inputExpense = int.tryParse(textController.text) ?? 0;
    textController.clear();
    refresh();
    return inputExpense;
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final BalanceState balanceState =
    //     ModalRoute.of(context)!.settings.arguments as BalanceState;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DAILY",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Flexible(
            child: dailyDate(),
            flex: 5,
          ),
          Flexible(
            flex: 50,
            fit: FlexFit.tight,
            child: bodyBuild(),
          ),
          Flexible(
            flex: 50,
            fit: FlexFit.tight,
            child: enterExpense(),
          ),
        ],
      ),
    );
  }

  Widget bodyBuild() {
    return Row(
      children: [
        Column(
          children: [
            Text(widget.balanceState.dailyConsumption.toString(),
                style: TextStyle(color: Colors.black, fontSize: 40)),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget dailyDate() {
    return Row(
      children: [
        Text(
          'DAY 1',
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
          ),
        ),
      ],
    );
  }

  Widget enterExpense() {
    return TextField(
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0),
        ),
        hintText: 'input expense',
        hintStyle: TextStyle(fontSize: 40, color: Colors.black),
      ),
      // showCursor: false,
      style: TextStyle(fontSize: 40),
      controller: textController,
      onSubmitted: (_) {
        var expenseValue = getValueForExpenseTextField();
        widget.balanceState.dailyConsumption -= expenseValue;
      },
    );
  }
}
