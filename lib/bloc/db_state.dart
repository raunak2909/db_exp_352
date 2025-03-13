import 'package:db_exp_352/note_model.dart';

abstract class DBState{}

class DBInitialState extends DBState{}
class DBLoadingState extends DBState{}
class DBLoadedState extends DBState{
  List<NoteModel> mNotes = [];
  DBLoadedState({required this.mNotes});
}
class DBErrorState extends DBState{
  String errorMsg;
  DBErrorState({required this.errorMsg});
}