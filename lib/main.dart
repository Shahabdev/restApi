import 'package:flutter/material.dart';
import 'package:rest_api10/Product_Screen.dart';
import 'package:rest_api10/creating_model.dart';
import 'package:rest_api10/exampFour_withoutplugin.dart';
import 'package:rest_api10/uploadimge_server.dart';
import 'package:rest_api10/user_info.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',


      home: const uploadimage_screen(),
    );
  }
}

