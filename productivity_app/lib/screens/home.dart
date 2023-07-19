// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:productivity_app/utils/header.dart';
import 'package:gap/gap.dart';
import 'package:localstorage/localstorage.dart';
import 'package:productivity_app/utils/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    fetchStorage();
    setState(() {
      tText.text = task;
    });
  }

  final LocalStorage storage = LocalStorage('localstorage_app');

  List todos = [];
  Map<String, dynamic> todo = {};
  String task = "";

  TextEditingController tText = TextEditingController();
  TextEditingController editCtrl = TextEditingController();

  void addTodo() {
    setState(() {
      todos = [
        ...todos,
        {"task": task, "completed": false}
      ];
    });
    FocusScope.of(context).unfocus();
    tText.clear();
    setState(() {
      task = "";
    });
    addtoStorage(todos);
  }

  void editTodo(data) {
    String editedValue = data["task"] ?? "";
    setState(() {
      editCtrl.text = data["task"];
    });
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit the Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: editCtrl,
                  onChanged: (value) {
                    setState(() {
                      editedValue = value;
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
                  data["task"] = editedValue;
                });
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
    addtoStorage(todos);
  }

  Future<void> addtoStorage(todooo) async {
    storage.setItem('todos', todooo);
    await storage.ready;
    print(storage.getItem('todos'));
  }

  Future<void> fetchStorage() async {
    await storage.ready;
    var sth = await storage.getItem('todos');
    setState(() {
      todos = sth ?? [];
    });
  }

  void clearStorage() {
    showDialog(
        context: context,
        builder: (BuildContext builder) {
          return AlertDialog(
            title: const Text("Clear Todos"),
            content: const SingleChildScrollView(
                child: Text("Are you sure, you want to clear the todos?")),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      todos.clear();
                      addtoStorage(todos);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, const Text("ToDo"), false),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  Column(
                    children: todos.map<Widget>((data) {
                      return Column(
                        children: [
                          InkWell(
                            onLongPress: () {
                              editTodo(data);
                              setState(() {});
                            },
                            onDoubleTap: () {
                              setState(() {
                                data["completed"] = !data["completed"];
                              });
                              addtoStorage(todos);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  right: 20, top: 2, bottom: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 275,
                                    child: Text(
                                      data["task"] ?? "Bruh",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: data["completed"]
                                              ? Colors.grey
                                              : Colors.black,
                                          decoration: data["completed"]
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        todos.remove(data);
                                      });
                                      addtoStorage(todos);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 21,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                              controller: tText,
                              onChanged: (text) {
                                setState(() {
                                  task = text;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                hintText: 'Add a todo',
                              )),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: RawMaterialButton(
                            onPressed: addTodo,
                            fillColor: Colors.deepPurple.shade300,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Styles.redColor),
                      onPressed: clearStorage,
                      child: const Text('Clear')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
