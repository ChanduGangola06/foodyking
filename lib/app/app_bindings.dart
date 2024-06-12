import 'package:flutter/material.dart';
import 'package:foodyking/app/controllers/home_controller.dart';
import 'package:foodyking/app/controllers/menu_controller.dart';
import 'package:foodyking/app/controllers/splash_controller.dart';
import 'package:get/get.dart';

import 'controllers/dashboard_controller.dart';

class AppBindings extends Bindings {
  // ignore: prefer_typing_uninitialized_variables
  var context;
  AppBindings({required this.context});

  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<HomeController>(HomeController());
    Get.put<MenuuController>(MenuuController());
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}
