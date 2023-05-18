import 'package:flutter/material.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';

class AuthenticationForm extends StatefulWidget {
  final Key? formKey;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType input;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const AuthenticationForm({
    super.key,
    required this.formKey, 
    required this.autovalidateMode,
    required this.controller, 
    this.obscureText = false,
    this.input = TextInputType.text,
    required this.hintText, 
    this.suffixIcon, 
    this.prefixIcon, 
    required this.validator,
    this.onChanged
  });

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.input,
        decoration: InputDecoration(
          hintText: widget.hintText,
          errorMaxLines: 2,
          hintStyle: h5(
            color: textGrey,
            fontWeight: FontWeight.normal
          ),
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: contextOrange,
              width: 2
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: contextGrey,
              width: 2
            )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: contextRed,
              width: 2
            )
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: contextRed,
              width: 2
            )
          ),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
        ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      )
    );
  }
}