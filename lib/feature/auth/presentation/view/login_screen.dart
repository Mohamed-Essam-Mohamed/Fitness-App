import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../widgets/login_body.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
          children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            ImageAsset.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(child: LoginBody())
      ]),
    );

  }

}