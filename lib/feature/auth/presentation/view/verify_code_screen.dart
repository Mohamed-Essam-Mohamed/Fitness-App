import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/animation_text.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/custom_auth_container.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/logo_app_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ForgetPasswordCubit>(context);

    return BackgroundApp(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state.isLoading) {
                  AppDialogs.showLoadingDialog(context);
                }
                if (state.isSuccess) {
                  context.pop();
                  context.pushNamed(Routes.changePassword, arguments: cubit);
                }
                if (state.isFailure) {
                  context.pop();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const LogoAppWidget(),
                  const SizedBox(height: 88),
                  AnimationText(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        LocaleKeys.Authentication_OtpCode.tr(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  AnimationText(
                    millDelay: 1200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        LocaleKeys.Authentication_EnterYourOtpCheckYourEmail.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomAuthContainer(
                    child: Column(
                      children: [
                        VerificationCode(
                          textStyle: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: AppColors.orange),
                          underlineColor: AppColors.white,
                          underlineUnfocusedColor: AppColors.orange,
                          autofocus: true,
                          length: 6,
                          padding: EdgeInsets.zero,
                          cursorColor: AppColors.orange,
                          onCompleted: (String value) async {
                            cubit.doIntend(
                              ForgetPasswordIntent(
                                status: ForgetPasswordStatus.verifyCode,
                                code: value,
                              ),
                            );
                          },
                          onEditing: (bool value) {},
                        ),
                        const SizedBox(height: 24),
                        BounceInDown(
                          delay: const Duration(milliseconds: 1800),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(38),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(LocaleKeys.Authentication_Confirm.tr()),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          LocaleKeys.Authentication_DidnotReceiveCode.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            LocaleKeys.Authentication_ResendCode.tr(),
                            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: AppColors.orange,
                                ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
