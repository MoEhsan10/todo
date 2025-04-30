import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  DefaultTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.hintStyle,
    this.style,
  });

  TextEditingController controller;
  String hintText;
  TextStyle? hintStyle;
  String? Function(String?)? validator;
  TextInputType keyboardType;
  bool isPassword;
  TextStyle? style;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
 late bool isObscure =widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        style: widget.style,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    isObscure =!isObscure;
                    setState(() {});
                  },
              icon: isObscure? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined) )
              : null,
        ),
        validator: widget.validator,
      obscureText: isObscure,
    );
  }
}
