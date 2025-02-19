import 'package:db_exp_352/db_helper.dart';
import 'package:db_exp_352/note_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DbHelper? mDb;

  DateFormat df = DateFormat.yMMMEd();

  List<NoteModel> mData = [];

  @override
  void initState() {
    super.initState();
    mDb = DbHelper.getInstance();
    getAllNotes();
  }

  void getAllNotes() async {
    mData = await mDb!.fetchAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ///DbHelper dbHelper = DbHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: mData.isNotEmpty
          ? ListView.builder(
              itemCount: mData.length,
              itemBuilder: (_, index) {
                var eachDate = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(mData[index].nCreatedAt));

                return ListTile(
                  title: Text(mData[index].nTitle),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mData[index].nDesc),
                      Text(df.format(eachDate)),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async{
                              bool check = await mDb!.updateNote(NoteModel(
                                  nTitle: "Updated Title",
                                  nDesc: "Updated Desc",
                                  nCreatedAt: mData[index].nCreatedAt,
                                  nId: mData[index].nId));

                              if(check){
                                getAllNotes();
                              }

                            },
                            icon: Icon(
                              Icons.edit,
                            )),
                        IconButton(
                            onPressed: () async{

                              bool check = await mDb!.deleteNote(mData[index].nId!);

                              if(check){
                                getAllNotes();
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ),
                );
              })
          : Center(
              child: Text("No notes yet!!"),
            ),
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

                                if(titleController.text.isNotEmpty && descController.text.isNotEmpty) {
                                  bool check = await mDb!.addNote(
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
                                  }
                                } else {

                                }
                              },
                              child: Text('Add')),
                          SizedBox(
                            width: 11,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, child: Text("Cancel")),
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
