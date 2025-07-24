import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/enum/status.dart';
import 'package:fitness_app/core/utils/image_picker_setting.dart';
import 'package:fitness_app/feature/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({required this.profileCubit, super.key});
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Text(
                'Profile Photo',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.of(context).pop();
                  profileCubit.photo =
                      await SelectImagePicker.chooseOneImage(SourceImage.camera);
                  profileCubit.photo != null
                      ? profileCubit
                          .doIntend(UpdateProfilePhotoAction(profileCubit.photo!))
                      : null;
                },
                child: const PhotoFromCameraOrGallery(
                  title: 'Camera',
                  icon: SvgAsset.camera,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.of(context).pop();
                  profileCubit.photo =
                      await SelectImagePicker.chooseOneImage(SourceImage.gallery);
                  profileCubit.photo != null
                      ? profileCubit
                          .doIntend(UpdateProfilePhotoAction(profileCubit.photo!))
                      : null;
                },
                child: const PhotoFromCameraOrGallery(
                  title: 'Gallery',
                  icon: SvgAsset.gallery,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class PhotoFromCameraOrGallery extends StatelessWidget {
  const PhotoFromCameraOrGallery({super.key, required this.title, required this.icon});
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.gray[AppColors.colorCode40]!)),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(icon),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(title),
            )
          ],
        ),
      ),
    );
  }
}
