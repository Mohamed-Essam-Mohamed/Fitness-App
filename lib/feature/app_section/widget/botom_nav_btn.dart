import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomItemNav extends StatelessWidget {
  const BottomItemNav({
    super.key,
    required this.iconPath,
    required this.onPressed,
    required this.index,
    required this.currentIndex,
  });
  final Function(int) onPressed;
  final String iconPath;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return InkWell(
      onTap: () {
        onPressed(index);
      },
      child: Container(
        height: AppSizes.blockSizeHorizontal * 13,
        width: AppSizes.blockSizeHorizontal * 17,
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            (currentIndex == index)
                ? Positioned(
                    left: AppSizes.blockSizeHorizontal * 4,
                    bottom: AppSizes.blockSizeHorizontal * 1.5,
                    child: SvgPicture.asset(
                      iconPath,
                      color: AppColors.black,
                      height: AppSizes.blockSizeHorizontal * 8,
                      width: AppSizes.blockSizeHorizontal * 8,
                    ),
                  )
                : Container(),
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: SvgPicture.asset(
                iconPath,
                color: (currentIndex == index) ? AppColors.orange : AppColors.white,
                height: AppSizes.blockSizeHorizontal * 8,
                width: AppSizes.blockSizeHorizontal * 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
