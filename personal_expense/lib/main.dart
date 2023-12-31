import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense/bloc/transaction_bloc.dart';
import 'package:personal_expense/bloc/transaction_state.dart';

import 'package:personal_expense/widgets/chart.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import 'package:personal_expense/widgets/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Personal Expenses',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.amber),
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                labelLarge: const TextStyle(
                    fontFamily: 'Quicksand', color: Colors.white)),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        home: BlocProvider(
          create: (context) => TransactionBloc(),
          child: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(transactionBloc: ctx.read<TransactionBloc>());
      },
    );
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWidget) {
    return [
      SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.25,
        child: Chart(),
      ),
      transactionListWidget,
    ];
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWidget) {
    return [
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: const Chart(),
            )
          : transactionListWidget,
    ];
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddingNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            actions: [
              IconButton(
                  onPressed: () => _startAddingNewTransaction(context),
                  icon: const Icon(Icons.add))
            ],
          ) as PreferredSizeWidget;
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar();
    final transactionListWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: const TransactionList(),
    );

    final pageBody = BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Switch.adaptive(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          })
                    ],
                  ),
                if (!isLandscape)
                  ..._buildPortraitContent(
                      mediaQuery, appBar as AppBar, transactionListWidget),
                if (isLandscape)
                  ..._buildLandscapeContent(
                      mediaQuery, appBar as AppBar, transactionListWidget),
              ],
            ),
          ),
        );
      },
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddingNewTransaction(context),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
          );
  }
}
