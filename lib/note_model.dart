import 'package:db_exp_352/db_helper.dart';

class NoteModel {
  int? nId;
  String nTitle;
  String nDesc;
  String nCreatedAt;

  NoteModel(
      {this.nId,
      required this.nTitle,
      required this.nDesc,
      required this.nCreatedAt});

  /// fromMap
  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
        nId: map[DbHelper.COLUMN_NOTE_ID],
        nTitle: map[DbHelper.COLUMN_NOTE_TITLE],
        nDesc: map[DbHelper.COLUMN_NOTE_DESC],
        nCreatedAt: map[DbHelper.COLUMN_NOTE_CREATED_AT]);
  }


  /// toMap
  Map<String, dynamic> toMap(){
    return {
      DbHelper.COLUMN_NOTE_TITLE : nTitle,
      DbHelper.COLUMN_NOTE_DESC : nDesc,
      DbHelper.COLUMN_NOTE_CREATED_AT : nCreatedAt
    };
  }






}
