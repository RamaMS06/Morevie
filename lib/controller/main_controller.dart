import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class MainController extends GetxController {
  RxInt tabIndex = 0.obs;
  RxList<Color> listColor = List.filled(3, Colors.black.withOpacity(0.2)).obs;

  changeTabIndex(int index) {
    tabIndex.value = index;
    listColor.value = List.filled(3, Colors.black.withOpacity(0.2));
    listColor[index] = Colors.blueAccent;
  }
}
