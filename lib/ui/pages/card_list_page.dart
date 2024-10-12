import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokimon_card_getx_demo/controllers/pokemon_controller.dart';
import 'package:pokimon_card_getx_demo/data/services/i_card_service.dart';
import 'package:pokimon_card_getx_demo/routes/app_routes.dart';
import 'package:pokimon_card_getx_demo/ui/themes/app_colors.dart';
import 'package:pokimon_card_getx_demo/ui/widgets/card_widget.dart';
import 'package:pokimon_card_getx_demo/ui/widgets/shimmer_text.dart';

class CardListPage extends StatelessWidget {
  final PokemonController controller = Get.put(
    PokemonController(cardService: Get.find<ICardService>()),
  );

  CardListPage({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Obx(() {
          if (controller.isLoading.value && controller.cards.isEmpty) {
            return const Center(child: ShimmerText(text: "Loading Cards..."));
          }

          if (!controller.isLoading.value && controller.cards.isEmpty) {
            return const Center(
                child: Text('No Pokémon found',
                    style: TextStyle(color: AppColors.primaryColor)));
          }

          return _buildCardGrid();
        }));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.primaryColor,
        title: SizedBox(
          height: 35,
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
                hintText: 'Search Pokémon...',
                filled: true,
                fillColor: AppColors.accentColor,
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                isDense: true),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) async {
              var searchResult = await controller.searchCards(value);
              if (searchResult != null) {
                Get.toNamed(AppRoutes.searchPage, arguments: {
                  'searchResult': searchResult,
                  'searchQuery': value
                });
              } else {
                _showSimpleDialog(context, value);
              }
              _searchController.clear();
            },
          ),
        ));
  }

  void _showSimpleDialog(BuildContext context, String searchQuery) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Error'),
            content: Text('There is no result for "$searchQuery"'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('OK'))
            ]);
      },
    );
  }

  Widget _buildCardGrid() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !controller.isLoading.value && // Check if not already loading
              controller.hasMore.value) {
            controller.loadMore(); // Trigger pagination
          }
          return true;
        },
        child: Stack(
          children: [
            Column(children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: controller.cards.length,
                  itemBuilder: (context, index) {
                    var card = controller.cards[index];
                    return CardWidget(card: card);
                  },
                ),
              ),
              Obx(() {
                // Show loading indicator if loading
                if (controller.isLoading.value && controller.cards.isNotEmpty) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                          child: ShimmerText(text: "Loading More Cards...")));
                }
                // Return an empty widget if not loading
                return const SizedBox.shrink();
              })
            ]),
            Obx(() {
              // Show loading indicator for search
              if (controller.isSearchLoading.value) {
                return const Center(
                    child: ShimmerText(text: "Loading Searched Cards..."));
              }
              // Return an empty widget if not loading
              return const SizedBox.shrink();
            })
          ],
        ));
  }
}
