import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListTileProfileWidget extends StatelessWidget {
  const ListTileProfileWidget({
    super.key,
    required this.image,
    required this.title,
    required this.trailing,
    this.richText = '',
    this.onTap,
    this.textColor,
  });
  final String image;
  final String title;
  final String richText;
  final Widget trailing;
  final Color? textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: ListTile(
        
        minTileHeight: 30,
        iconColor: AppColors.redOrange,
        onTap: onTap,
        leading: SvgPicture.asset(
          image,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(AppColors.redOrange, BlendMode.srcIn),
        ),
        title: Text.rich(
          TextSpan(
            text: title,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(letterSpacing: 0.26, color: textColor),
            children: <TextSpan>[
              TextSpan(
                text: richText.isEmpty ? richText : ' ( $richText )',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(letterSpacing: 0.26, color: AppColors.redOrange),
              ),
            ],
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
