import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/register/register_body.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class RegisterFirstPartScreen extends StatefulWidget {
  const RegisterFirstPartScreen({super.key});

  @override
  State<RegisterFirstPartScreen> createState() =>
      _RegisterFirstPartScreenState();
}

class _RegisterFirstPartScreenState extends State<RegisterFirstPartScreen> {
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
              ),
              SizedBox(height: 20),
              RegisterBody()
            ],
          ),
        ),
      ),
    );
  }
}
