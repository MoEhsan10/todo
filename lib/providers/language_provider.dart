import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';

  LanguageProvider(){
    getLanguage();
  }
  void changeAppLanguage(String newLanguage) {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    saveLanguage(currentLanguage);
    notifyListeners();
  }

  void saveLanguage(String lang)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(lang =='ar'){
      prefs.setString('language', 'ar');
    }else{
      prefs.setString('language', 'en');
    }
  }

  void getLanguage()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedLang =prefs.getString('language')??'en';
    if(cachedLang == 'ar'){
      currentLanguage = 'ar';
    }else{
      currentLanguage ='en';
    }
    notifyListeners();
  }
}