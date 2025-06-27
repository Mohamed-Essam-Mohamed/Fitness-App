import 'package:fitness_app/core/common/animation/loading_shimmer.dart';
import 'package:flutter/material.dart';

class CategoryListLoading extends StatelessWidget {
  const CategoryListLoading({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          width: width,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              LoadingShimmer(
                width: width,
                height: height,
              ),
              Positioned(
                bottom: 0,
                child: LoadingShimmer(
                  width: width,
                  height: height * 0.3,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: 10,
      ),
    );
  }
}
