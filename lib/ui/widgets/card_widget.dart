import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokimon_card_getx_demo/data/model/pokemon_card.dart';
import 'package:pokimon_card_getx_demo/routes/app_routes.dart';
import 'package:pokimon_card_getx_demo/ui/themes/app_colors.dart';
import 'package:pokimon_card_getx_demo/ui/widgets/shimmer_card.dart';

class CardWidget extends StatelessWidget {
  final PokemonCard card;

  const CardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.detailPage, arguments: card);
      },
      child: Card(
        color: AppColors.accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: card.imageUrl,
                placeholder: (context, url) => const ShimmerCard(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                card.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
