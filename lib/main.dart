import 'package:db_exp_352/bloc/db_bloc.dart';
import 'package:db_exp_352/db_helper.dart';
import 'package:db_exp_352/db_provider.dart';
import 'package:db_exp_352/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => DBBloc(dbHelper: DbHelper.getInstance()),
        child: HomePage(),
      ),
    );
  }
}

///create a DB
///create a table
///table which has columns (nId (pk, integer, autoincrement), nTitle (text), nDesc (text), nCreatedAt (text))
