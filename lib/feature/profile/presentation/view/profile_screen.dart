import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/dummy/dummy_constant.dart';
import 'package:fitness_app/core/extensions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/storage_helper/app_shared_preference_helper.dart';
import 'package:fitness_app/core/storage_helper/secure_storage_helper.dart';
import 'package:fitness_app/core/enum/status.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:fitness_app/feature/profile/presentation/widgets/list_tile_profile_widget.dart';
import 'package:fitness_app/feature/profile/presentation/widgets/select_language_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _profileCubit;
  late final TextTheme theme;
  @override
  void initState() {
    super.initState();
    _profileCubit = serviceLocator.get<ProfileCubit>();
  }

  didChangeDependencies() {
    theme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 100),
      child: Column(
        children: [
          Text(
            LocaleKeys.Profile_ProfileTitle.tr(),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600, height: 1.20),
          ),
          const SizedBox(height: 20),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state.isGetProfileLoading,
                child: Column(
                  children: [
                    CustomCacheNetworkImage(
                      imageUrl: state.isGetProfileLoading
                          ? dummyImageProfileUrl
                          : state.dataUserEntity.photo,
                      isCircular: true,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.isGetProfileLoading
                          ? dummyText
                          : '${state.dataUserEntity.firstName} ${state.dataUserEntity.lastName}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w600, height: 1.20),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: const Color(0xCC242424),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              children: [
                ListTileProfileWidget(
                  image: SvgAsset.profile,
                  title: LocaleKeys.Profile_EditProfile.tr(),
                  trailing: _iconWidget(),
                ),
                _dividerWidget(),
                ListTileProfileWidget(
                  image: SvgAsset.change,
                  title: LocaleKeys.Profile_ChangePassword.tr(),
                  trailing: _iconWidget(),
                  onTap: () {
                    context.pushNamed(Routes.forgotPassword);
                  },
                ),
                _dividerWidget(),
                const SelectLanguageWidget(),
                _dividerWidget(),
                ListTileProfileWidget(
                  image: SvgAsset.lockSetting,
                  title: LocaleKeys.Profile_Security.tr(),
                  trailing: _iconWidget(),
                ),
                _dividerWidget(),
                ListTileProfileWidget(
                  image: SvgAsset.securityWarning,
                  title: LocaleKeys.Profile_PrivacyPolicy.tr(),
                  trailing: _iconWidget(),
                ),
                _dividerWidget(),
                ListTileProfileWidget(
                  image: SvgAsset.help,
                  title: LocaleKeys.Profile_Help.tr(),
                  trailing: _iconWidget(),
                ),
                _dividerWidget(),
                ListTileProfileWidget(
                  image: SvgAsset.logout,
                  title: LocaleKeys.Profile_Logout.tr(),
                  trailing: _iconWidget(),
                  textColor: AppColors.redOrange,
                  onTap: () {
                    AppDialogs.showMessage(
                      context: context,
                      onPressedAction1: () {
                        context.pop();
                      },
                      onPressedAction2: () async {
                        context.pushNamedAndRemoveUntil(Routes.login);
                        await SharedPreferencesHelper.clearDataUserPref();
                        await SecureStorageHelper.instance
                            .deleteSecure(key: AppValues.token);
                      },
                      titleAction1: 'No',
                      titleAction2: 'Yes',
                      message: 'Are you sure to close the application?',
                    );
                  },
                ),
              ],
            ),
          )
        ],
    log('ProfileScreen');
    return BlocProvider(
      create: (context) => _profileCubit..doIntend(GetDataProfileAction()),
      child: BackgroundApp(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 60),
          child: Column(
            children: [
              Text(
                LocaleKeys.Profile_ProfileTitle.tr(),
                style: theme.titleLarge!
                    .copyWith(fontWeight: FontWeight.w600, height: 1.20),
              ),
              const SizedBox(height: 40),
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (pre, cur) {
                  if (pre.getProfileStatus != cur.getProfileStatus) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state.isGetProfileLoading,
                    child: Column(
                      children: [
                        BlocBuilder<ProfileCubit, ProfileState>(
                          buildWhen: (pre, cur) {
                            if (pre.profilePhotoStatus !=
                                cur.profilePhotoStatus) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            if (state.profilePhotoStatus == Status.loading) {
                              return const CircleAvatar(
                                  backgroundColor: AppColors.darkBackground,
                                  radius: 50,
                                  child: CircularProgressIndicator(
                                      color: AppColors.orange));
                            }
                            return CustomCacheNetworkImage(
                              imageUrl: state.isGetProfileLoading
                                  ? dummyImageProfileUrl
                                  : state.dataUserEntity.photo,
                              isCircular: true,
                              width: 100,
                              height: 100,
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<ProfileCubit, ProfileState>(
                          buildWhen: (pre, cur) {
                            if (pre.updateProfileStatus != Status.success) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            return Text(
                              state.isGetProfileLoading
                                  ? dummyText
                                  : '${state.dataUserEntity.firstName} ${state.dataUserEntity.lastName}',
                              textAlign: TextAlign.center,
                              style: theme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.w600, height: 1.20),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: const Color(0xCC242424),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    ListTileProfileWidget(
                      image: SvgAsset.profile,
                      title: LocaleKeys.Profile_EditProfile.tr(),
                      trailing: _iconWidget(),
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.editProfile,
                            arguments: _profileCubit);
                      },
                    ),
                    _dividerWidget(),
                    ListTileProfileWidget(
                      image: SvgAsset.change,
                      title: LocaleKeys.Profile_ChangePassword.tr(),
                      trailing: _iconWidget(),
                    ),
                    _dividerWidget(),
                    const SelectLanguageWidget(),
                    _dividerWidget(),
                    ListTileProfileWidget(
                      image: SvgAsset.lockSetting,
                      title: LocaleKeys.Profile_Security.tr(),
                      trailing: _iconWidget(),
                    ),
                    _dividerWidget(),
                    ListTileProfileWidget(
                      image: SvgAsset.securityWarning,
                      title: LocaleKeys.Profile_PrivacyPolicy.tr(),
                      trailing: _iconWidget(),
                    ),
                    _dividerWidget(),
                    ListTileProfileWidget(
                      image: SvgAsset.help,
                      title: LocaleKeys.Profile_Help.tr(),
                      trailing: _iconWidget(),
                    ),
                    _dividerWidget(),
                    ListTileProfileWidget(
                      image: SvgAsset.logout,
                      title: LocaleKeys.Profile_Logout.tr(),
                      trailing: _iconWidget(),
                      textColor: AppColors.redOrange,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Divider _dividerWidget() {
    return const Divider(
      color: AppColors.bgBottomNav,
      endIndent: 16,
      indent: 16,
      thickness: 1.5,
    );
  }

  Icon _iconWidget() {
    return const Icon(
      Icons.arrow_forward_ios,
      size: 20,
    );
  }
}
