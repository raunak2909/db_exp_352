import 'package:db_exp_352/bloc/db_event.dart';
import 'package:db_exp_352/bloc/db_state.dart';
import 'package:db_exp_352/db_helper.dart';
import 'package:db_exp_352/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DBBloc extends Bloc<DBEvent, DBState> {
  DbHelper dbHelper;

  DBBloc({required this.dbHelper}) : super(DBInitialState()) {
    on<AddNoteEvent>((event, emit) async {
      emit(DBLoadingState());

      bool check = await dbHelper.addNote(
          newNote: NoteModel(
              nTitle: event.title,
              nDesc: event.desc,
              nCreatedAt: DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString()));

      if (check) {
        List<NoteModel> allNotes = await dbHelper.fetchAllNotes();
        emit(DBLoadedState(mNotes: allNotes));
      } else {
        emit(DBErrorState(errorMsg: "Note not added!!"));
      }
    });
    on<GetInitialNoteEvent>((event, emit) async {
      emit(DBLoadingState());
      List<NoteModel> allNotes = await dbHelper.fetchAllNotes();
      emit(DBLoadedState(mNotes: allNotes));
    });

    ///update
    on<UpdateNoteEvent>((event, emit) async{
      emit(DBLoadingState());

      bool check = await dbHelper.updateNote(
          NoteModel(nTitle: event.title,
              nDesc: event.desc,
              nCreatedAt: event.createdAt));

      if(check){
        List<NoteModel> allNotes = await dbHelper.fetchAllNotes();
        emit(DBLoadedState(mNotes: allNotes));
      } else {
        emit(DBErrorState(errorMsg: "Note not Updated!!"));
      }
    });

    ///delete
    on<DeleteNoteEvent>((event, emit) async{

      emit(DBLoadingState());

      bool check =  await dbHelper.deleteNote(event.id);

      if(check){
        List<NoteModel> allNotes = await dbHelper.fetchAllNotes();
        emit(DBLoadedState(mNotes: allNotes));
      } else {
        emit(DBErrorState(errorMsg: "Note not Updated!!"));
      }

    });


  }
}
