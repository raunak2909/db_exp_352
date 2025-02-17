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
  static const String TABLE_NOTE = 'notes';
  static const String COLUMN_NOTE_ID = 'nId';
  static const String COLUMN_NOTE_TITLE = 'nTitle';
  static const String COLUMN_NOTE_DESC = 'nDesc';
  static const String COLUMN_NOTE_CREATED_AT = 'nCreatedAt';

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

    return await openDatabase(dbPath, version: 1, onCreate: (db, version){
      ///create tables
      db.execute("Create table $TABLE_NOTE ( $COLUMN_NOTE_ID integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text, $COLUMN_NOTE_CREATED_AT text)");

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
  
  Future<bool> addNote({required String title, required String desc}) async{
    Database db = await getDB();

    int rowsEffected = await db.insert(TABLE_NOTE, {
        COLUMN_NOTE_TITLE : title,
        COLUMN_NOTE_DESC : desc,
        COLUMN_NOTE_CREATED_AT: DateTime.now().millisecondsSinceEpoch.toString(),
    });

    return rowsEffected>0;

  }

  Future<List<Map<String, dynamic>>> fetchAllNotes() async{
    var db = await getDB();

    List<Map<String, dynamic>> mNotes = await db.query(TABLE_NOTE);

    /// select * from $TABLE_NOTE

    return mNotes;
  }

}
