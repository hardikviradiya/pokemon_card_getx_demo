import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokimon_card_getx_demo/data/model/pokemon_card.dart';
import 'package:pokimon_card_getx_demo/ui/themes/app_colors.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PokemonCard card = Get.arguments;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: AppColors.accentColor),
          title: Text(card.name,
              style: const TextStyle(color: AppColors.accentColor))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: card.name,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(0, 4))
                          ]),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: CachedNetworkImage(imageUrl: card.imageUrl)))),
              const SizedBox(height: 20),

              // Card details section
              _buildDetailCard("Set", card.set),
              const SizedBox(height: 10),

              // Type section with badges
              _buildDetailCard("Type", card.types?.join(', ') ?? "N/A"),

              const SizedBox(height: 10),

              // Weakness section
              _buildDetailCard(
                "Weakness",
                card.weaknesses?.map((weakness) => weakness.type).join(', ') ??
                    "None",
              ),

              const SizedBox(height: 10),

              // Artist information
              _buildDetailCard("Artist", card.artist)
            ],
          ),
        ),
      ),
    );
  }

  // Detail card helper method
  Widget _buildDetailCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
