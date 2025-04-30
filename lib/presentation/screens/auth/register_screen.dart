import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/firebase_functions/firebase_function.dart';
import 'package:todo_app_v2/presentation/screens/auth/login_screen.dart';
import 'package:todo_app_v2/presentation/screens/auth/provider/user_provider.dart';
import 'package:todo_app_v2/presentation/screens/home/home_screen.dart';

import '../../../core/utils/app_dark_styles.dart';
import '../../../core/utils/app_light_Styles.dart';
import '../../../core/utils/colors_manager.dart';
import '../../../providers/theme_provider.dart';
import '../../Widgets/default_elevated_button.dart';
import '../../Widgets/default_textFormField.dart';
import 'widget/email_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isLight = themeProvider.isLightTheme();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register,
          style: isLight ? ApplightStyle.loginRegister : AppDarkStyles.loginRegister,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextFormField(
                controller: fullNameController,
                hintText: AppLocalizations.of(context)!.fullName,
                hintStyle: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : ApplightStyle.hintStyle,
                style: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : AppDarkStyles.hintStyle,
                keyboardType: TextInputType.name,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please, Enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DefaultTextFormField(
                controller: userNameController,
                hintText: AppLocalizations.of(context)!.userName,
                hintStyle: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : ApplightStyle.hintStyle,
                style: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : AppDarkStyles.hintStyle,
                keyboardType: TextInputType.name,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please, Enter your user name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DefaultTextFormField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.email,
                hintStyle: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : ApplightStyle.hintStyle,
                style: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : AppDarkStyles.hintStyle,
                keyboardType: TextInputType.emailAddress,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please, Enter your email address';
                  }
                  if (!isValidEmail(input)) {
                    return 'Email bad format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DefaultTextFormField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.password,
                hintStyle: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : ApplightStyle.hintStyle,
                style: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : AppDarkStyles.hintStyle,
                isPassword: true,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please, Enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DefaultTextFormField(
                controller: rePasswordController,
                hintText: AppLocalizations.of(context)!.password,
                hintStyle: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : ApplightStyle.hintStyle,
                style: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : AppDarkStyles.hintStyle,
                isPassword: true,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please, Confirm your Password';
                  }
                  if (input != passwordController.text) {
                    return 'password doesn\'t match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.h),
              DefaultElevatedButton(onPressed: register, label: AppLocalizations.of(context)!.register),
              SizedBox(height: 8.h),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(AppLocalizations.of(context)!.haveAccount,)),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    FirebaseFunction.register(
            fullName: fullNameController.text,
            userName: userNameController.text,
            email: emailController.text,
            password: passwordController.text,
            rePassword: rePasswordController.text)
        .then((user) {
      Provider.of<UserProvider>(context, listen: false).updateUser(user);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }).catchError((error) {
      String? message;
      if (error is FirebaseAuthException) {
        message = error.message;
      }
      Fluttertoast.showToast(
          msg: message ?? "Something went wrong",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 7,
          backgroundColor: ColorsManager.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
