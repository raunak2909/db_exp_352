import 'package:db_exp_352/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        bool check =  await mDb!.addNote(title: "NewNote", desc: "Live life king size!!");

        if(check){
          print("Note Added");
          getAllNotes();
        }

      }, child: Icon(Icons.add),),
    );
  }
}
