import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/base_state/base_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/validator.dart';
import '../view_model/login/login_cubit.dart';
import '../view_model/login/login_state.dart';
import 'bottom_section.dart';

class LoginContentWidget extends StatefulWidget {
  const LoginContentWidget({super.key});

  @override
  State<LoginContentWidget> createState() => _LoginContentWidgetState();
}

class _LoginContentWidgetState extends State<LoginContentWidget> {
  late LoginCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = serviceLocator<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state.baseState is BaseSuccessState) {
          Navigator.pushReplacementNamed(context, Routes.appSection);
        } else if (state.baseState is BaseErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppToast.showToast(
                context: context,
                description:
                    (state.baseState as BaseErrorState).exception.toString(),
                type: ToastificationType.error,
                title: LocaleKeys.Error_LoginFailed.tr());
          });
        }
      }, builder: (context, state) {
        final isLoading = state.baseState is BaseLoadingState;

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  LocaleKeys.Authentication_Login.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Form(
                key: cubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: cubit.emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined,
                              color: AppColors.gray[AppColors.colorCode10]),
                          hintText:
                              LocaleKeys.Authentication_EnterYourEmail.tr(),
                          labelText: LocaleKeys.Authentication_Email.tr(),
                        ),
                        validator: (value) => Validator.validateEmail(value),
                        onTapOutside: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: cubit.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: AppColors.gray[AppColors.colorCode10],
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_outlined,
                            color: AppColors.gray[AppColors.colorCode10],
                          ),
                          hintText:
                              LocaleKeys.Authentication_EnterYourPassword.tr(),
                          labelText: LocaleKeys.Authentication_Password.tr(),
                        ),
                        validator: (value) => Validator.validatePassword(value),
                        onTapOutside: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                      BottomSection(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (state.isFormValid) {
                                      cubit.doIntent(LoginAction());
                                    }
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : Text(LocaleKeys.Authentication_Login.tr()),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: LocaleKeys.Authentication_DonotHaveAnAccount
                                  .tr(),
                              style: Theme.of(context).textTheme.labelSmall,
                              children: [
                                TextSpan(
                                  text: LocaleKeys.Authentication_Register.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: AppColors.lightOrange,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.lightOrange,
                                      ),
                                  // recognizer: TapGestureRecognizer()..onTap = onRegisterTap,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
