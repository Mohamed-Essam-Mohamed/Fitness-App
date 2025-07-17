import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/login_body.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = serviceLocator<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          top: true,
          child: Scaffold(
            body: BlocProvider(
              create: (context) => cubit,
              child: const LoginBody(),
            ),
          ),
        ),
      ),
    );
  }
}
