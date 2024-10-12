import 'package:flutter/material.dart';
import 'package:pokimon_card_getx_demo/ui/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerText extends StatelessWidget {
  final String text;

  const ShimmerText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primaryColor,
      highlightColor: Colors.grey[100]!,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
