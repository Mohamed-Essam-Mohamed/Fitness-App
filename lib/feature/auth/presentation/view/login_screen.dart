import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:flutter/material.dart';

import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/login_body.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const BackgroundApp(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          top: true,
          child: Scaffold(
            body: LoginBody(),
          ),
        ),
      ),
    );
  }
}
