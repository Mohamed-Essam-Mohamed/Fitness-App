import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/utils/validator.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/register/bottom_section.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/routes/routes.dart';
import '../../view_model/models/collecting_data_model.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key,});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}
late RegisterCubit cubit;

class _RegisterBodyState extends State<RegisterBody> {

  @override
  void initState() {
    super.initState();
    cubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
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
            child: SingleChildScrollView(
              child: Form(
                key:cubit.formKey  ,
                child: Column(
                  children: [
                    Text(LocaleKeys.Authentication_register.tr(),
                        style: theme.textTheme.titleLarge),
                    const SizedBox(height: 16),

                    // First Name
                    TextFormField(
                      controller: cubit.firstNameController,
                      validator: Validator.validateName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(SvgAsset.user),
                        ),
                        label:
                        Text(LocaleKeys.Authentication_FirstName.tr()),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Last Name
                    TextFormField(
                      controller: cubit.lastNameController,
                      validator: Validator.validateName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(SvgAsset.user),
                        ),
                        label: Text(LocaleKeys.Authentication_LastName.tr()),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: cubit.emailController,
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
                      controller: cubit.passwordController,
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
                          cubit.updateUserData();
                          Navigator.of(context).pushNamed(
                            Routes.selectGender,
                            arguments:DataModel(cubit.passwordController.text, cubit.emailController.text, cubit.firstNameController.text, cubit.lastNameController.text) ,
                          );

                          print(cubit.emailController.text);
                          print("fffffffffffffffffffffffffff");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.Authentication_register.tr()),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Already have account
                    RichText(
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Go to login');
                          },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataModel
{


  String firstname;
  String LastName;
  String email;
  String password;

  DataModel(this.password,this.email,this.firstname,this.LastName);



}
