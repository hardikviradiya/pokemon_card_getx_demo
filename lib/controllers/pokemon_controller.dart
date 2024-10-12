import 'package:get/get.dart';
import 'package:pokimon_card_getx_demo/data/model/pokemon_card.dart';
import 'package:pokimon_card_getx_demo/data/services/i_card_service.dart';

class PokemonController extends GetxController {
  final ICardService cardService;
  var cards = <PokemonCard>[].obs;
  var isLoading = false.obs;
  var isSearchLoading = false.obs;
  var page = 1;
  var hasMore = true.obs;

  PokemonController({required this.cardService});

  @override
  void onInit() {
    fetchCards();
    super.onInit();
  }

  Future<void> fetchCards() async {
    if (!hasMore.value || isLoading.value) return;

    try {
      isLoading(true);
      var fetchedCards = await cardService.fetchCards(page);
      if (fetchedCards.isEmpty) {
        hasMore(false); // No more data to fetch
      } else {
        cards.addAll(fetchedCards);
        page++; // Increment page for next call
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cards');
    } finally {
      isLoading(false);
    }
  }

  Future<List<PokemonCard>?> searchCards(String searchQuery) async {
    try {
      isSearchLoading(true);
      var searchedCards = await cardService.searchCards(searchQuery);
      if (searchedCards.isNotEmpty) {
        return searchedCards;
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search cards');
      return null;
    } finally {
      isSearchLoading(false);
    }
  }

  // Method to trigger when user scrolls to the bottom
  void loadMore() {
    fetchCards();
  }
}
