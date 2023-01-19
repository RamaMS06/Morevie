import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:morevie/controller/setting_controller.dart';
import 'package:morevie/utils/components.dart';

class SettingPage extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SettingController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: Column(
          children: [
            CardButton(callback: () {
              // Get.changeTheme(
              //     Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
            })
          ],
        ),
      ),
    );
  }
}
