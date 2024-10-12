import 'package:pokimon_card_getx_demo/data/model/pokemon_card.dart';

abstract class ICardService {
  Future<List<PokemonCard>> fetchCards(int page);
  Future<List<PokemonCard>> searchCards(String searchQuery);
}
