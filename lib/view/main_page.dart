import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morevie/controller/main_controller.dart';
import 'package:morevie/view/home_page.dart';
import 'package:morevie/view/search_page.dart';
import 'package:morevie/view/setting_page.dart';

class MainPage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          child: const Icon(Icons.search),
          onPressed: () {
            controller.changeTabIndex(2);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
            child: IndexedStack(
          index: controller.tabIndex.value,
          children: [HomePage(), SettingPage(), SearchPage()],
        )),
        bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: const [Icons.home, Icons.settings],
            activeIndex: controller.tabIndex.value,
            activeColor: Colors.black.withOpacity(0.8),
            inactiveColor: Colors.black.withOpacity(0.2),
            gapLocation: GapLocation.center,
            splashSpeedInMilliseconds: 0,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: controller.changeTabIndex)));
  }
}
