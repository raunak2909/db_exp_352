import 'package:db_exp_352/note_model.dart';

abstract class DBEvent{}


class AddNoteEvent extends DBEvent{
  String title, desc;
  AddNoteEvent({required this.title, required this.desc});
}
class UpdateNoteEvent extends DBEvent{
  String title, desc, createdAt;
  int id;
  UpdateNoteEvent({required this.title, required this.desc, required this.id, required this.createdAt});
}
class DeleteNoteEvent extends DBEvent{
  int id;
  DeleteNoteEvent({required this.id});
}
class GetInitialNoteEvent extends DBEvent{}