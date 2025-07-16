import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/dialogs/app_toasts.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/utils/validator.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_state.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/animation_text.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/bottom_section.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/text_form_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

class LoginContentWidget extends StatefulWidget {
  const LoginContentWidget({super.key});

  @override
  State<LoginContentWidget> createState() => _LoginContentWidgetState();
}

class _LoginContentWidgetState extends State<LoginContentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.baseState is BaseSuccessState) {
          context.pop();
          Navigator.pushReplacementNamed(context, Routes.appSection);
        } else if (state.baseState is BaseLoadingState) {
          AppDialogs.showLoadingDialog(context);
        } else if (state.baseState is BaseErrorState) {
          context.pop();
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              AppToast.showToast(
                context: context,
                description: (state.baseState as BaseErrorState).exception.toString(),
                type: ToastificationType.error,
                title: LocaleKeys.Error_LoginFailed.tr(),
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimationText(
              millDelay: 1250,
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Text(
                  LocaleKeys.Authentication_Login.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Form(
              key: context.read<LoginCubit>().formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: context.read<LoginCubit>().emailController,
                    validator: Validator.validateEmail,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            SvgAsset.mail,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      hintText: LocaleKeys.Authentication_Email.tr(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormWidget(
                    controller: context.read<LoginCubit>().passwordController,
                    validator: Validator.validatePassword,
                    prefixIcon: SvgAsset.lock,
                    suffixIcon: SvgAsset.eye,
                    obscureText: true,
                    hintText: LocaleKeys.Authentication_Password.tr(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.pushNamed(Routes.forgotPassword);
                      },
                      child: Text(
                        LocaleKeys.Authentication_ForgetPassword.tr(),
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: AppColors.lightOrange,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.lightOrange,
                            ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  const BottomSection(),
                  BounceInDown(
                    delay: const Duration(milliseconds: 700),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () async {
                        if (context.read<LoginCubit>().formKey.currentState!.validate()) {
                          context.read<LoginCubit>().doIntent(LoginAction());
                        }
                      },
                      child: Text(LocaleKeys.Authentication_Login.tr()),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: LocaleKeys.Authentication_DonotHaveAnAccount.tr(),
                            style: Theme.of(context).textTheme.labelSmall,
                            children: [
                              TextSpan(
                                text: LocaleKeys.Authentication_Register.tr(),
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      color: AppColors.lightOrange,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.lightOrange,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context)
                                      .pushNamed(Routes.registerView),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
