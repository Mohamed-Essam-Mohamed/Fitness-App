import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/route_generator.dart';
import 'package:fitness_app/core/utils/validator.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/bottom_section.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {

  late RegisterCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<RegisterCubit>();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageAsset.backgroundImage),
              fit: BoxFit.cover)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            //  SizedBox(height: 22),
              SizedBox(
                height: context.hp(15),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: Image.asset(ImageAsset.logo),
                  ),
                ),
              ),
              SizedBox(height: 36),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.Authentication_heyThere.tr(),
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      LocaleKeys.Authentication_createAnAccount.tr(),
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
              ), SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Stack(
              children: [
                // background blur
                ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(36, 36, 36, 0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),

                // form section
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Form(
                    key:cubit.formKey ,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(LocaleKeys.Authentication_Register.tr(),
                              style: theme.textTheme.titleLarge),
                          const SizedBox(height: 16),

                          // First Name
                          TextFormField(
                            controller:cubit.firstName,
                            validator: Validator.validateName,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(SvgAsset.profile),
                              ),
                              label:
                              Text(LocaleKeys.Authentication_FirstName.tr()),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Last Name
                          TextFormField(
                            controller: cubit.lastName,
                            validator: Validator.validateName,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(SvgAsset.profile),
                              ),
                              label: Text(LocaleKeys.Authentication_LastName.tr()),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Email
                          TextFormField(
                            controller: cubit.email,
                            validator: Validator.validateEmail,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(SvgAsset.mail),
                              ),
                              labelText: LocaleKeys.Authentication_Email.tr(),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Password
                          TextFormField(
                            controller: cubit.password,
                            validator: Validator.validatePassword,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.visibility_outlined),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(SvgAsset.lock),
                              ),
                              labelText: LocaleKeys.Authentication_Password.tr(),
                            ),
                          ),

                          const SizedBox(height: 24),
                          const BottomSection(),
                          const SizedBox(height: 24),

                          // Register Button
                          ElevatedButton(
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                widget.pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );

                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(LocaleKeys.Authentication_Register.tr()),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Already have account
                          InkWell(
                            onTap: ()=> Navigator.of(context).pop(),

                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: LocaleKeys
                                        .Authentication_AlreadyHaveAnAccount
                                        .tr(),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.Authentication_Login.tr(),
                                    style: theme.textTheme.labelMedium,
                                  ),
                                ],


                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

        )],
          ),
        ),
      ),
    );
  }
}
