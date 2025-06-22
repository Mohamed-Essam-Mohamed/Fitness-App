import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/dialogs/app_toasts.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/animation_text.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/custom_auth_container.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/logo_app_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
                if (state.isForgetLoading) {
                  AppDialogs.showLoadingDialog(context);
                }
                if (state.isForgetSuccess) {
                  context.pop();
                  context.pushNamed(Routes.verifyCode, arguments: cubit);
                }
                if (state.isForgetFailure) {
                  context.pop();
                  AppToast.showToast(
                    context: context,
                    title: '',
                    description: state.errorFromForgetPassword,
                    type: ToastificationType.error,
                  );
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
                          LocaleKeys.Authentication_EnterYourEmail.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    AnimationText(
                      millDelay: 1200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          LocaleKeys.Authentication_ForgetPassword.tr(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomAuthContainer(
                      child: Column(
                        spacing: 24,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 16, right: 8),
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: SvgPicture.asset(
                                    SvgAsset.mail,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              hintText: LocaleKeys.Authentication_Email.tr(),
                            ),
                          ),
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
                                if (formKey.currentState!.validate()) {
                                  context.read<ForgetPasswordCubit>().doIntend(
                                        ForgetPasswordIntent(
                                          status: ForgetPasswordStatus.forgotPassword,
                                          email: _emailController.text,
                                        ),
                                      );
                                }
                              },
                              child: Text(LocaleKeys.Authentication_SendOtp.tr()),
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

  late TextEditingController _emailController;
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
