import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/firebasestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textcontroller = TextEditingController();
  Firebasestoree add = Firebasestoree();

  openNote({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textcontroller,
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              if (docID == null) {
                add.createNote(textcontroller.text);
              } else {
                add.updateNote(docID, textcontroller.text);
              }

              // add.createNote(textcontroller.text);
              textcontroller.clear();
              Navigator.pop(context);
            },
            child: const Text("Add Note"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 27, 50),
        title: const Text(
          "Note App",
          style: TextStyle(
              color: Colors.cyan, fontSize: 30, fontStyle: FontStyle.italic),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          openNote();
        },
        child: const Icon(
          Icons.add,
          color: Colors.lightBlue,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: add.getNote(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Show Data
            List datalist = snapshot.data!.docs;
            return ListView.builder(
              itemCount: datalist.length,
              itemBuilder: (context, index) {
                // get indivisual  Documents

                DocumentSnapshot document = datalist[index];
                // ignore: unused_local_variable
                String documentID = document.id;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                String notesli = data['note'];

                return ListTile(
                    title: Text(
                      notesli,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 176, 7),
                          fontSize: 35,
                          fontStyle: FontStyle.italic),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            openNote(docID: documentID);
                          },
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton(
                          onPressed: () {
                            add.deleteNote(documentID);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ));
              },
            );
          } else {
            return const Text(
              "No Data",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 176, 7),
                  fontSize: 35,
                  fontStyle: FontStyle.italic),
            );

            // if no data msg
          }
        },
      ),
    );
  }
}
