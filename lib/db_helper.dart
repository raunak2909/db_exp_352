import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  /// make this class constructor private
  ///private constructor
  DbHelper._();
  //static final DbHelper mInstance = DbHelper._();
  static DbHelper getInstance() => DbHelper._();

  /// DB will only be created once, it will be destroyed only when user clear the cache data or uninstall the app.

  /// will always open the DB, (database path -> "data/data/www.something.com/databases/dbname.db")
  /// if it exists we will open it, and
  /// if it does not exist we will create it and then open it
  Database? _db;

  Future<Database> getDB() async{
    _db ??= await openDB();
    return _db!;

    /*if(_db!=null){
      return _db!;
    } else {
      _db = await openDB();
      return _db!;
    }*/
  }

  Future<Database> openDB() async{

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path,"noteDB.db");

    return await openDatabase(dbPath, onCreate: (db, version){
      ///create tables
      db.execute("Create table notes ( nId integer primary key auto increment, nTitle text, nDesc text, nCreatedAt text)");

    });

  }

  /// if i'm calling to execute queries on DB from our app like 10 times

  /// insert -> db -> openDb -> execute
  /// fetch -> db -> execute
  /// fetch -> db -> execute
  /// fetch -> db -> execute
  /// fetch -> db -> execute
  /// fetch -> db -> execute
  /// fetch -> db -> execute
  
  void insertNote({required String title, required String desc}) async{
    var db = await getDB();

  }

}
