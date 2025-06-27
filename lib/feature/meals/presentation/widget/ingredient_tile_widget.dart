import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class IngredientTileWidget extends StatelessWidget {
  IngredientTileWidget({super.key, required this.name , required this.amount});
  String name;
  String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 16
              )),
              Text(amount, style:Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.orange
              )),
            ],
          ),
          Divider(
            color: AppColors.gray[AppColors.colorCode80],
            thickness: 1,
            indent: 6,
            endIndent: 6,
          )

        ],
      ),
    );

  }
}
