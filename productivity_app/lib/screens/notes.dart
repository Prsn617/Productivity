import 'dart:math';
import 'package:flutter/material.dart';
import 'package:productivity_app/screens/note_detail.dart';
import 'package:productivity_app/utils/header.dart';
import 'package:gap/gap.dart';
import 'package:productivity_app/utils/styles.dart';
import 'package:localstorage/localstorage.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  void initState() {
    super.initState();
  }

  final LocalStorage storage = LocalStorage('localstorage_app');

  List notes = [
    {
      "id": Random().nextInt(10000),
      "title": "Food Tree System",
      "notes": "Abcdefghi, jklm, nopqrstuvwx, yz,"
    },
    {
      "id": Random().nextInt(10000),
      "title": "No Tree System",
      "notes": "Laayeko maya bhulaauna garo chha"
    },
    {
      "id": Random().nextInt(10000),
      "title": "Khaaney kura",
      "notes": "Chithhi vitra raakhera pathaaudai chhu"
    },
  ];
  String notess = "";
  String titles = "";

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();

  void addNotes() {
    String tits = "";
    String nots = "";
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Notes'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  // controller: titleCtrl,
                  onChanged: (value) {
                    setState(() {
                      tits = value;
                    });
                  },
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                TextField(
                  // controller: notesCtrl,
                  onChanged: (value) {
                    setState(() {
                      nots = value;
                    });
                  },
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                setState(() {
                  notes = [
                    ...notes,
                    {
                      "id": Random().nextInt(10000),
                      "title": tits,
                      "notes": nots
                    }
                  ];
                });
                addtoStorage(notes);
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void addtoStorage(notesss) {
    storage.setItem('notes', notesss);
  }

  Future<void> fetchStorage() async {
    await storage.ready;
    var a = await storage.getItem('notes');
    setState(() {
      notes = a ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, const Text("Notes"), false),
      floatingActionButton: FloatingActionButton(
        onPressed: addNotes,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: notes.map<Widget>((data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteDetail(
                                        noteId: data["id"],
                                        noter: notes,
                                      )));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            data["title"],
                            style: Styles.h4,
                          ),
                        ),
                      ),
                      const Gap(10),
                    ],
                  );
                }).toList(),
              )
            ],
          )
        ],
      )),
    );
  }
}
