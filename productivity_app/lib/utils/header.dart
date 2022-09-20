import 'package:flutter/material.dart';
import 'package:productivity_app/utils/styles.dart';

// ignore: non_constant_identifier_names
AppBar Header(context, title, bool back) {
  return AppBar(
    title: title,
    toolbarHeight: 50.0,
    backgroundColor: Styles.purpleColor,
    automaticallyImplyLeading: back,
  );
}
