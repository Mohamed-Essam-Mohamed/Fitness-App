import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFormFieldForNameAndEmail extends StatefulWidget {
  const CustomTextFormFieldForNameAndEmail({
    required this.icon,
    required this.controller,
    super.key,
    this.enabled,
  });
  final String icon;
  final TextEditingController controller;
  final bool? enabled;

  @override
  State<CustomTextFormFieldForNameAndEmail> createState() =>
      _CustomTextFormFieldForNameAndEmailState();
}

class _CustomTextFormFieldForNameAndEmailState
    extends State<CustomTextFormFieldForNameAndEmail> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SvgPicture.asset(widget.icon),
        ),
      ),
    );
  }
}
