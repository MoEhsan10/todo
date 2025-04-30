import 'package:flutter/material.dart';
import 'package:todo_app_v2/models/user_model.dart';

class UserProvider extends ChangeNotifier{
  UserModel? currentUser;

  void updateUser(UserModel? user){
    currentUser =user;
    notifyListeners();
  }
}