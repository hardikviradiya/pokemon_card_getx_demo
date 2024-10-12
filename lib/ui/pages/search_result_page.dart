import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokimon_card_getx_demo/data/model/pokemon_card.dart';
import 'package:pokimon_card_getx_demo/ui/themes/app_colors.dart';
import 'package:pokimon_card_getx_demo/ui/widgets/card_widget.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final List<PokemonCard> searchResult = arguments['searchResult'];
    final String searchQuery = arguments['searchQuery'];

    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.accentColor),
            title: Text(searchQuery,
                style: const TextStyle(color: AppColors.accentColor))),
        body: _buildCardGrid(searchResult));
  }

  Widget _buildCardGrid(List<PokemonCard> searchResult) {
    return Column(children: [
      Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                var card = searchResult[index];
                return CardWidget(card: card);
              }))
    ]);
  }
}
