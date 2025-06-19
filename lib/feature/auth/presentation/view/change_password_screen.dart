import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/utils/validator.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/animation_text.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/custom_auth_container.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/logo_app_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
                }
                if (state.isFailure) {
                  context.pop();
                }
              },
              child: Form(
                key: formKey,
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
                          LocaleKeys.Authentication_MakeSureIts8CharactersOrMore.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    AnimationText(
                      millDelay: 1200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          LocaleKeys.Authentication_CreateNewPassword.tr(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomAuthContainer(
                      child: Column(
                        spacing: 24,
                        children: [
                          TextFormWidget(
                            controller: _newPasswordController,
                            validator: Validator.validatePassword,
                            prefixIcon: SvgAsset.lock,
                            suffixIcon: SvgAsset.eye,
                            obscureText: true,
                            hintText: LocaleKeys.Authentication_Password.tr(),
                          ),
                          TextFormWidget(
                            controller: _confirmPasswordController,
                            validator: (val) => Validator.validateConfirmPassword(
                                val, _newPasswordController.text),
                            prefixIcon: SvgAsset.lock,
                            suffixIcon: SvgAsset.eye,
                            obscureText: true,
                            hintText: LocaleKeys.Authentication_ConfirmPassword.tr(),
                          ),
                          BounceInDown(
                            delay: const Duration(milliseconds: 1800),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(38),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.doIntend(ForgetPasswordIntent(
                                    status: ForgetPasswordStatus.changePassword,
                                    password: _newPasswordController.text,
                                  ));
                                }
                              },
                              child: Text(LocaleKeys.Authentication_Done.tr()),
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
      ),
    );
  }

  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

class TextFormWidget extends StatefulWidget {
  TextFormWidget({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    required this.suffixIcon,
    required this.prefixIcon,
    this.obscureText = true,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String suffixIcon;
  final String prefixIcon;
  bool obscureText;

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              widget.obscureText = !widget.obscureText;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                widget.suffixIcon,
                fit: BoxFit.contain,
                color: widget.obscureText ? null : AppColors.redOrange,
              ),
            ),
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: SizedBox(
            width: 25,
            height: 25,
            child: SvgPicture.asset(
              widget.prefixIcon,
              fit: BoxFit.contain, // مهم جدًا
            ),
          ),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
