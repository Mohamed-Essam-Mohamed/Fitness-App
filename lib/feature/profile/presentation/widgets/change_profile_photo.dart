import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/core/common/widget/custom_snack_bar.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/enum/status.dart';

import 'package:fitness_app/feature/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:fitness_app/feature/profile/presentation/widgets/bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChangeProfilePhoto extends StatelessWidget {
  const ChangeProfilePhoto({required this.url, required this.profileCubit, super.key});
  final String url;
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.darkBackground,
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state.profilePhotoStatus == Status.success) {
                CustomSnackBar.showSnack(
                  context: context,
                  title: state.successMessage,
                  stateType: true,
                );
              } else if (state.profilePhotoStatus == Status.failure) {
                CustomSnackBar.showSnack(
                  context: context,
                  title: state.errorMessage,
                  stateType: false,
                );
              }
            },
            bloc: profileCubit,
            builder: (context, state) {
              if (state.profilePhotoStatus == Status.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.lightOrange,
                  ),
                );
              }
              return ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomCacheNetworkImage(
                    imageUrl: state.dataUserEntity.photo,
                  ),
                ),
              );
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
                    return BottomSheetContent(profileCubit: profileCubit);
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bgCategory,
                  border: Border.all(
                    color: AppColors.orange,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(SvgAsset.editProfile),
                ),
              ),
            ))
      ],
    );
  }
}
