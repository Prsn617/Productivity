import 'package:flutter/material.dart';

import '../utils/header.dart';

class Pomo extends StatefulWidget {
  const Pomo({super.key});

  @override
  State<Pomo> createState() => _PomoState();
}

class _PomoState extends State<Pomo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, const Text("PomoDoro"), false),
    );
  }
}
