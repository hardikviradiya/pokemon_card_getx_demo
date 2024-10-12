import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokimon_card_getx_demo/data/services/card_service.dart';
import 'package:pokimon_card_getx_demo/data/services/i_card_service.dart';
import 'package:pokimon_card_getx_demo/routes/app_routes.dart';
import 'package:pokimon_card_getx_demo/ui/pages/card_list_page.dart';

void main() {
  Get.put<ICardService>(CardService());

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon Cards App',
      initialRoute: AppRoutes.homePage,
      getPages: AppRoutes.routes,
      home: CardListPage()));
}
