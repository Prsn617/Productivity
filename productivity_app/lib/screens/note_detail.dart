import 'package:flutter/material.dart';
import 'package:productivity_app/utils/bottom_bar.dart';
import 'package:productivity_app/utils/header.dart';
import 'package:gap/gap.dart';
import 'package:productivity_app/utils/styles.dart';
import 'package:localstorage/localstorage.dart';

class NoteDetail extends StatefulWidget {
  final int noteId;
  final List noter;
  const NoteDetail({Key? key, required this.noteId, required this.noter})
      : super(key: key);

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  @override
  void initState() {
    super.initState();

    notes = widget.noter;
    for (var i in notes) {
      if (i["id"] == widget.noteId) {
        noterr = i;
      }
    }
    titles = noterr["title"];
    notess = noterr["notes"];

    titleCtrl.text = titles;
    notesCtrl.text = notess;
  }

  final LocalStorage storage = LocalStorage('localstorage_app');

  String titles = "";
  String notess = "";
  Map<String, dynamic> noterr = {};
  List notes = [];

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();

  void addtoStorage(notesss) {
    storage.setItem('notes', notesss);
  }

  Future<bool> onBackPress() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomBar(
                  id: 1,
                )));
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: Header(context, const Text("Notes Details"), true),
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              Column(
                children: [
                  TextField(
                      controller: titleCtrl,
                      onChanged: (value) {
                        print(notes);
                        setState(() {
                          titles = value;
                          notes
                              .where((i) => i["id"] == noterr["id"])
                              .toList()
                              .forEach((j) => j["title"] = value);
                        });
                        addtoStorage(notes);
                      },
                      style: Styles.h4),
                  const Gap(10),
                  TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    controller: notesCtrl,
                    onChanged: (value) {
                      setState(() {
                        notess = value;
                        notes = notes.map((i) {
                          i["notes"] =
                              i["id"] == noterr["id"] ? value : i["notes"];
                        }).toList();
                      });
                      addtoStorage(notes);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
