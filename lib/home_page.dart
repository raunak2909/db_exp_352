import 'dart:math';

import 'package:db_exp_352/bloc/db_bloc.dart';
import 'package:db_exp_352/bloc/db_event.dart';
import 'package:db_exp_352/bloc/db_state.dart';
import 'package:db_exp_352/db_helper.dart';
import 'package:db_exp_352/db_provider.dart';
import 'package:db_exp_352/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DateFormat df = DateFormat.yMMMEd();

  List<NoteModel> mData = [];

  @override
  void initState() {
    super.initState();

    context.read<DBBloc>().add(GetInitialNoteEvent());

    //context.read<DBProvider>().getInitialNotes();
    /*mDb = DbHelper.getInstance();
    getAllNotes();*/
  }

  /*void getAllNotes() async {
    mData = await mDb!.fetchAllNotes();
    setState(() {});
  }*/

  ///Consumer<DBProvider>(builder: (_, provider, __){
  //         mData = provider.getAllNotes();
  //         return mData.isNotEmpty
  //             ? ListView.builder(
  //             itemCount: mData.length,
  //             itemBuilder: (_, index) {
  //               var eachDate = DateTime.fromMillisecondsSinceEpoch(
  //                   int.parse(mData[index].nCreatedAt));
  //
  //               return ListTile(
  //                 tileColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
  //                 title: Text(mData[index].nTitle, style: TextStyle(
  //                   decoration: TextDecoration.lineThrough
  //                 ),),
  //                 subtitle: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(mData[index].nDesc),
  //                     Text(df.format(eachDate)),
  //                   ],
  //                 ),
  //                 trailing: SizedBox(
  //                   width: 100,
  //                   child: Row(
  //                     children: [
  //                       IconButton(
  //                           onPressed: () async{
  //                             context.read<DBProvider>().updateNote(NoteModel(
  //                                 nTitle: mData[index].nTitle,
  //                                 nDesc: "Updated Desc",
  //                                 nCreatedAt: mData[index].nCreatedAt,
  //                                 nId: mData[index].nId));
  //
  //                             /*bool check = await mDb!.updateNote(NoteModel(
  //                                 nTitle: mData[index].nTitle,
  //                                 nDesc: "Updated Desc",
  //                                 nCreatedAt: mData[index].nCreatedAt,
  //                                 nId: mData[index].nId));
  //
  //                             if(check){
  //                               getAllNotes();
  //                             }*/
  //
  //                           },
  //                           icon: Icon(
  //                             Icons.edit,
  //                           )),
  //                       IconButton(
  //                           onPressed: () async{
  //
  //                             context.read<DBProvider>().deleteNote(mData[index].nId!);
  //
  //                             /*bool check = await mDb!.deleteNote(mData[index].nId!);
  //
  //                             if(check){
  //                               getAllNotes();
  //                             }*/
  //                           },
  //                           icon: Icon(
  //                             Icons.delete,
  //                             color: Colors.red,
  //                           )),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             })
  //             : Center(
  //           child: Text("No notes yet!!"),
  //         );
  //       })

  @override
  Widget build(BuildContext context) {
    ///DbHelper dbHelper = DbHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<DBBloc, DBState>(builder: (_, state) {
        if(state is DBLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }

        if(state is DBErrorState){
          return Center(child: Text("Error: ${state.errorMsg}"),);
        }

        if(state is DBLoadedState){
          return state.mNotes.isNotEmpty
              ? ListView.builder(
              itemCount: state.mNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(state.mNotes[index].nTitle),
                  subtitle: Text(state.mNotes[index].nDesc),
                );
              })
              : Center(
            child: Text('No Notes yet!!'),
          );
        }

        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          titleController.text = "Default";
          descController.clear();

          showModalBottomSheet(
              context: context,
              builder: (_) {
                return Container(
                  padding: EdgeInsets.all(11),
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        "Add Note",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          label: Text("Title"),
                          hintText: "Enter title here..",
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(
                          label: Text("Desc"),
                          hintText: "Enter desc here..",
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              onPressed: () async {
                                if (titleController.text.isNotEmpty &&
                                    descController.text.isNotEmpty) {
                                  /*context.read<DBProvider>().addNote(NoteModel(
                                      nTitle: titleController.text,
                                      nDesc: descController.text,
                                      nCreatedAt: DateTime
                                          .now()
                                          .millisecondsSinceEpoch
                                          .toString()));
*/

                                  context.read<DBBloc>().add(AddNoteEvent(
                                      title: titleController.text,
                                      desc: descController.text));

                                  Navigator.pop(context);

                                  /*bool check = await mDb!.addNote(
                                      newNote: NoteModel(
                                          nTitle: titleController.text,
                                          nDesc: descController.text,
                                          nCreatedAt: DateTime
                                              .now()
                                              .millisecondsSinceEpoch
                                              .toString()));

                                  if (check) {
                                    getAllNotes();
                                    Navigator.pop(context);
                                  }*/
                                } else {}
                              },
                              child: Text('Add')),
                          SizedBox(
                            width: 11,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
