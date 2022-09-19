import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:productivity_app/utils/styles.dart';
import 'package:gap/gap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tText.text = task;
    });
  }

  List todos = [];
  Map<String, dynamic> todo = {};
  String task = "";

  TextEditingController tText = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('To-Do'))),
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
                            onDoubleTap: () {
                              setState(() {
                                data["completed"] = !data["completed"];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  right: 20, top: 2, bottom: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
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
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        todos.remove(data);
                                      });
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
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
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
                            fillColor: Colors.green,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: const Icon(Icons.add),
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
                      onPressed: () {
                        setState(() {
                          todos.clear();
                        });
                      },
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
