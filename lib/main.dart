import 'package:flutter/material.dart';
import 'package:handling_network_data/components/colors.dart';
import 'package:handling_network_data/index_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: mainColor),
    home: IndexPage(),
  ));
}

