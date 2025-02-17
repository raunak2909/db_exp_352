import 'package:db_exp_352/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DbHelper? mDb;

  List<Map<String, dynamic>> mData = [];


  @override
  void initState(){
    super.initState();
    mDb = DbHelper.getInstance();
    getAllNotes();
  }

  void getAllNotes() async{
    mData = await mDb!.fetchAllNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    ///DbHelper dbHelper = DbHelper();


    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      body: mData.isNotEmpty ? ListView.builder(
        itemCount: mData.length,
          itemBuilder: (_, index){
          return ListTile(
            title: Text(mData[index][DbHelper.COLUMN_NOTE_TITLE]),
            subtitle: Text(mData[index][DbHelper.COLUMN_NOTE_DESC]),
          );
      }) : Center( child: Text("No notes yet!!"),),
      floatingActionButton: FloatingActionButton(onPressed: () async{

        titleController.clear();
        descController.clear();

        showModalBottomSheet(context: context, builder: (_){
          return Container(
            padding: EdgeInsets.all(11),
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: [
                Text("Add Note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),
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
                    OutlinedButton(onPressed: () async{
                      bool check = await mDb!.addNote(title: titleController.text, desc: descController.text);

                      if(check){
                        getAllNotes();
                        Navigator.pop(context);
                      }

                    }, child: Text('Add')),
                    SizedBox(
                      width: 11,
                    ),
                    OutlinedButton(onPressed: (){

                    }, child: Text("Cancel")),
                  ],
                )
              ],
            ),
          );
        });

      }, child: Icon(Icons.add),),
    );
  }
}
