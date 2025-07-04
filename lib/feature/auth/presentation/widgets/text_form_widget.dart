import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextFormWidget extends StatefulWidget {
  TextFormWidget({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    required this.suffixIcon,
    required this.prefixIcon,
    this.obscureText = true,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String suffixIcon;
  final String prefixIcon;
  bool obscureText;

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              widget.obscureText = !widget.obscureText;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                widget.suffixIcon,
                fit: BoxFit.contain,
                color: widget.obscureText ? null : AppColors.redOrange,
              ),
            ),
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: SizedBox(
            width: 25,
            height: 25,
            child: SvgPicture.asset(
              widget.prefixIcon,
              fit: BoxFit.contain,
            ),
          ),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
