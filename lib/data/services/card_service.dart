import 'dart:convert';

import 'package:pokimon_card_getx_demo/data/model/pokemon_card.dart';
import 'package:pokimon_card_getx_demo/data/services/i_card_service.dart';
import 'package:http/http.dart' as http;

class CardService implements ICardService {
  final String apiUrl = 'https://api.pokemontcg.io/v2/cards';
  final int pageSize = 10;

  @override
  Future<List<PokemonCard>> fetchCards(int page, {String? searchQuery}) async {
    var url = '$apiUrl?page=$page&pageSize=$pageSize';
    if (searchQuery != null) {
      url = '$apiUrl?q=set.name:$searchQuery';
    }

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return List<PokemonCard>.from(
          jsonData['data'].map((e) => PokemonCard.fromJson(e)));
    } else {
      throw Exception('Failed to load cards');
    }
  }

  @override
  Future<List<PokemonCard>> searchCards(String searchQuery) async {
    var url = '$apiUrl?q=set.name:$searchQuery';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return List<PokemonCard>.from(
          jsonData['data'].map((e) => PokemonCard.fromJson(e)));
    } else {
      throw Exception('Failed to search cards');
    }
  }
}
