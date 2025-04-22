import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  DefaultTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  });

  TextEditingController controller;
  String hintText;
  String? Function(String?)? validator;
  TextInputType keyboardType;
  bool isPassword;

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
        decoration: InputDecoration(
          hintText: widget.hintText,
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
