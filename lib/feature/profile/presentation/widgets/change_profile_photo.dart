import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/enum/status.dart' show SourceImage, Status;
import 'package:fitness_app/core/utils/image_picker_setting.dart';
import 'package:fitness_app/feature/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChangeProfilePhoto extends StatelessWidget {
  const ChangeProfilePhoto(
      {required this.url, required this.profileCubit, super.key});
  final String url;
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.black,
          child: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: profileCubit,
            builder: (context, state) {
             
              if (state.updateProfileStatus == Status.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.lightOrange,
                  ),
                );
              } else if (state.updateProfileStatus == Status.success) {
               
                return ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.file(
                      profileCubit.photo!,
                      fit: BoxFit.fill,
                    ));
              } else {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CustomCacheNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.fill,
                    ));
              }
            },
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(children: [
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
                            ]),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    profileCubit.photo =
                                        await SelectImagePicker.chooseOneImage(
                                            SourceImage.camera);
                                    Navigator.of(context).pop();
                                    profileCubit.photo != null
                                        ? profileCubit.doIntend(
                                            UpdateProfilePhotoAction(
                                                profileCubit.photo!))
                                        : null;
                                  },
                                  child: const PhotoFromCameraOrGallery(
                                    title: 'Camera',
                                    icon: SvgAsset.camera,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    profileCubit.photo =
                                        await SelectImagePicker.chooseOneImage(
                                            SourceImage.gallery);
                                    Navigator.of(context).pop();
                                    profileCubit.photo != null
                                        ? profileCubit.doIntend(
                                            UpdateProfilePhotoAction(
                                                profileCubit.photo!))
                                        : null;
                                  },
                                  child: const PhotoFromCameraOrGallery(
                                    title: 'Gallery',
                                    icon: SvgAsset.gallery,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bgCategory,
                    border: Border.all(color: AppColors.orange)),
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(SvgAsset.editProfile)),
              ),
            ))
      ],
    );
  }
}

class PhotoFromCameraOrGallery extends StatelessWidget {
  const PhotoFromCameraOrGallery(
      {super.key, required this.title, required this.icon});
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
