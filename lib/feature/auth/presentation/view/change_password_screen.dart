import 'package:animate_do/animate_do.dart';
import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/utils/validator.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/animation_text.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/custom_auth_container.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/logo_app_widget.dart';
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
                  context.pushNamed(
                    Routes.verifyCode,
                    arguments: context.read<ForgetPasswordCubit>(),
                  );
                }
                if (state.isFailure) {
                  context.pop();
                  // AppToast.showToast(context: context, title: 'Error', description: '', type: type)
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
                        'make sure its 8 characters or more',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  AnimationText(
                    millDelay: 1200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "create new password",
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
                          hintText: 'Password',
                        ),
                        TextFormWidget(
                          controller: _confirmPasswordController,
                          validator: (val) => Validator.validateConfirmPassword(
                              val, _newPasswordController.text),
                          prefixIcon: SvgAsset.lock,
                          suffixIcon: SvgAsset.eye,
                          obscureText: true,
                          hintText: 'Confirm Password',
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
                              // context.pushNamed(Routes.verifyCode);
                            },
                            child: const Text('Sent OTP'),
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

  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

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
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String suffixIcon;
  final String prefixIcon;
  bool obscureText;

  TextFormWidget({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    required this.suffixIcon,
    required this.prefixIcon,
    this.obscureText = true,
  });

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
