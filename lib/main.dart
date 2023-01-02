import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:morevie/view/home.dart';

void main() => runApp(const MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: HomePage());
  }
}
