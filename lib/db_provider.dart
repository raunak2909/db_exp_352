import 'package:db_exp_352/db_helper.dart';
import 'package:db_exp_352/note_model.dart';
import 'package:flutter/cupertino.dart';

class DBProvider extends ChangeNotifier{
  DbHelper dbHelper;
  DBProvider({required this.dbHelper});

  List<NoteModel> _mNotes = [];

  List<NoteModel> getAllNotes() => _mNotes;

  ///add
  void addNote(NoteModel newNote) async{
    bool check = await dbHelper.addNote(newNote: newNote);

    if(check){
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }

  }

  void getInitialNotes() async{
    _mNotes = await dbHelper.fetchAllNotes();
    notifyListeners();
  }
  void updateNote(NoteModel updateNote) async{
    bool check = await dbHelper.updateNote(updateNote);
    if(check){
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }

  void deleteNote(int id) async{
    bool check = await dbHelper.deleteNote(id);
    if(check){
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }


}