import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/register/bottom_section.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(36, 36, 36, 0.5),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.Authentication_register.tr(),
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              SvgAsset.user,
                            ),
                          ),
                          label:
                              Text(LocaleKeys.Authentication_FirstName.tr())),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SvgPicture.asset(SvgAsset.user),
                          ),
                          label: Text(LocaleKeys.Authentication_LastName.tr())),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SvgPicture.asset(SvgAsset.mail),
                          ),
                          labelText: LocaleKeys.Authentication_Email.tr()),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_outlined),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SvgPicture.asset(SvgAsset.lock),
                          ),
                          labelText: LocaleKeys.Authentication_Password.tr()),
                    ),
                    SizedBox(height: 24),
                    BottomSection(),
                    SizedBox(height: 24),
                    ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.Authentication_register.tr())
                          ], 
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: LocaleKeys
                                    .Authentication_AlreadyHaveAnAccount.tr()),
                            TextSpan(
                                text: LocaleKeys.Authentication_Login.tr(),
                                style: theme.textTheme.labelMedium)
                          ],
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('hello wwwww');
                            }),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
