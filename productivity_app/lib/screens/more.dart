import 'package:flutter/material.dart';

import '../utils/header.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(context, const Text("More"), false),
        backgroundColor: Colors.grey.shade100,
        body: Center(
          child: Text(
            'Coming Soon...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade500,
            ),
          ),
        ));
  }
}
