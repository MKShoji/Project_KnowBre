import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "Meus Cards"),
    Tab(text: "Meus videos"),
    Tab(text: "Salvos"),
  ];

  late TabController tabController;

  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
