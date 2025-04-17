import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/presentation/screens/auth/login_screen.dart';

import '../../Widgets/default_elevated_button.dart';
import '../../Widgets/default_textFormField.dart';
import 'email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen ({super.key});
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
    return Scaffold(
      appBar: AppBar(
        title:const Text('Register'),
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
                hintText: 'Full Name',
                keyboardType: TextInputType.name,
                validator: (input) {
                  if(input==null || input.trim().isEmpty){
                    return 'Please, Enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DefaultTextFormField(
                controller: userNameController,
                hintText: 'User name',
                keyboardType: TextInputType.name,
                validator: (input) {
                  if(input==null || input.trim().isEmpty){
                    return 'Please, Enter your user name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DefaultTextFormField(
                controller: emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (input) {
                  if (input == null || input
                      .trim()
                      .isEmpty) {
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
                hintText: 'Password',
                isPassword: true,
                validator: (input) {
                  if (input == null || input
                      .trim()
                      .isEmpty) {
                    return 'Please, Enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DefaultTextFormField(
                controller: rePasswordController,
                hintText: 're-Password',
                isPassword: true,
                validator: (input) {
                  if(input==null || input.trim().isEmpty){
                    return 'Please, Confirm your Password';
                  }
                  if(input!=passwordController.text){
                    return 'password doesn\'t match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.h),
              DefaultElevatedButton(onPressed: login, label: 'Login'),
              SizedBox(height: 8.h),
              TextButton(onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                    LoginScreen.routeName);
              }, child: const Text("Already have an account?")),
            ],
          ),
        ),
      ),
    );
  }
  void login() {
  }
}