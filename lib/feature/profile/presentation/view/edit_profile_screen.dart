import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/animation/loading_shimmer.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/enum/status.dart';
import 'package:fitness_app/feature/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:fitness_app/feature/profile/presentation/widgets/change_profile_photo.dart';
import 'package:fitness_app/feature/profile/presentation/widgets/custom_text_form_field_for_name_and_email.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({required this.profileCubit, super.key});
  final ProfileCubit profileCubit;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextTheme theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageAsset.thirdBg), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(LocaleKeys.Profile_EditProfile.tr()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (pre, cur) {
                if (pre.getProfileStatus != cur.getProfileStatus) {
                  return true;
                }

                return false;
              },
              bloc: widget.profileCubit,
              builder: (context, state) {
                print("it ren=build now bakkkar***************************");
                if (state.getProfileStatus == Status.failure) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: theme.labelLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            widget.profileCubit
                                .doIntend(GetDataProfileAction());
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Text('Try again'),
                          ))
                    ],
                  );
                }
                return Skeletonizer(
                  enabled: state.isGetProfileLoading,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        state.isGetProfileLoading
                            ? const LoadingShimmer(
                                isCircular: true, width: 120, height: 120)
                            : ChangeProfilePhoto(
                                profileCubit: widget.profileCubit,
                                url: state.dataUserEntity.photo,
                              ),
                        const SizedBox(height: 8),
                        state.isGetProfileLoading
                            ? CustomShimmerLoading(
                                isBig: false,
                              )
                            : Text(
                                '${state.dataUserEntity.firstName}  ${state.dataUserEntity.lastName}',
                                style: theme.labelLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                        const SizedBox(height: 40),
                        state.isGetProfileLoading
                            ? CustomShimmerLoading(
                                isBig: true,
                              )
                            : CustomTextFormFieldForNameAndEmail(
                                icon: SvgAsset.profile,
                                controller: TextEditingController(
                                    text: state.dataUserEntity.firstName),
                              ),
                        const SizedBox(height: 16),
                        state.isGetProfileLoading
                            ? CustomShimmerLoading(
                                isBig: true,
                              )
                            : CustomTextFormFieldForNameAndEmail(
                                icon: SvgAsset.profile,
                                controller: TextEditingController(
                                    text: state.dataUserEntity.lastName),
                              ),
                        const SizedBox(height: 16),
                        state.isGetProfileLoading
                            ? CustomShimmerLoading(
                                isBig: true,
                              )
                            : CustomTextFormFieldForNameAndEmail(
                                icon: SvgAsset.mail,
                                controller: TextEditingController(
                                    text: state.dataUserEntity.email),
                              ),
                        const SizedBox(height: 40),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: state.isGetProfileLoading
                              ? CustomShimmerLoading(
                                  isBig: false,
                                )
                              : const TitleTextForWeightGoalActivityLevel(
                                  title: 'Your Weight',
                                ),
                        ),
                        const SizedBox(height: 16),
                        state.isGetProfileLoading
                            ? CustomShimmerLoading(
                                isBig: true,
                              )
                            : TextFormField(
                                controller: TextEditingController(
                                    text:
                                        state.dataUserEntity.weight.toString()),
                                decoration: InputDecoration(
                                  fillColor: AppColors.lightWhite.withAlpha(40),
                                  filled: true,
                                ),
                              ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: state.isGetProfileLoading
                              ? CustomShimmerLoading(
                                  isBig: false,
                                )
                              : const TitleTextForWeightGoalActivityLevel(
                                  title: 'Your Goal',
                                ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        state.isGetProfileLoading
                            ? CustomShimmerLoading(
                                isBig: true,
                              )
                            : TextFormField(
                                controller: TextEditingController(
                                    text: state.dataUserEntity.goal),
                                decoration: InputDecoration(
                                  fillColor: AppColors.lightWhite.withAlpha(40),
                                  filled: true,
                                ),
                              ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: state.isGetProfileLoading
                              ? CustomShimmerLoading(
                                  isBig: false,
                                )
                              : const TitleTextForWeightGoalActivityLevel(
                                  title: 'Your Activity Level',
                                ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        state.isGetProfileLoading
                            ? CustomShimmerLoading(
                                isBig: true,
                              )
                            : TextFormField(
                                controller: TextEditingController(
                                    text: state.dataUserEntity.activityLevel),
                                decoration: InputDecoration(
                                  fillColor: AppColors.lightWhite.withAlpha(40),
                                  filled: true,
                                ),
                              ),
                        const SizedBox(height: 50),
                        // Elevet
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TitleTextForWeightGoalActivityLevel extends StatelessWidget {
  const TitleTextForWeightGoalActivityLevel({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Wrap(
        children: [
          Text(
            '$title  (',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            'tap to edit',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            ')',
            style: Theme.of(context).textTheme.displayLarge,
          )
        ],
      ),
    );
  }
}

class CustomShimmerLoading extends StatelessWidget {
  CustomShimmerLoading({required this.isBig, super.key});
  bool isBig;

  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      width: isBig ? double.infinity : 100,
      height: isBig ? 45 : 20,
      borderRadius: BorderRadius.circular(40),
    );
  }
}
