import 'package:get/get.dart';
import 'package:pokimon_card_getx_demo/ui/pages/card_list_page.dart';
import 'package:pokimon_card_getx_demo/ui/pages/pokemon_detail_page.dart';
import 'package:pokimon_card_getx_demo/ui/pages/search_result_page.dart';

class AppRoutes {
  static const String homePage = '/';
  static const String searchPage = '/search';
  static const String detailPage = '/detail';

  static List<GetPage> routes = [
    GetPage(
      name: homePage,
      page: () => CardListPage(),
    ),
    GetPage(
      name: searchPage,
      page: () => const SearchResultPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: detailPage,
      page: () => const PokemonDetailPage(),
      transition: Transition.fadeIn,
    ),
  ];
}
