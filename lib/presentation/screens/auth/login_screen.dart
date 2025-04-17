import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/presentation/Widgets/default_elevated_button.dart';
import 'package:todo_app_v2/presentation/Widgets/default_textFormField.dart';
import 'package:todo_app_v2/presentation/screens/auth/register_screen.dart';

import 'email_validator.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});
   static const String routeName ='/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =TextEditingController();

  TextEditingController passwordController =TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (input) {
                    if(input==null || input.trim().isEmpty){
                      return 'Please, Enter your email address';
                    }
                    if(!isValidEmail(input)){
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
                    if(input==null || input.trim().isEmpty){
                      return 'Please, Enter your password';
                    }
                    return null;
                  },
              ),
              SizedBox(height: 32.h),
              DefaultElevatedButton(onPressed: login, label: 'Login'),
              SizedBox(height: 8.h),
              TextButton(onPressed: () {
                Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
              }, child: Text("Don't have an account?")),
            ],
          ),
        ),
      ),
    );
  }

  void login(){
    if(formKey.currentState!.validate()){
      //login logic
    }
  }
}
