import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';

class AppDarkStyles{
  static TextStyle? appBarTextStyle =GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.w700,color: ColorsManager.darkBLue);
  static TextStyle? loginRegister =GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.w700,color: ColorsManager.white);
  static TextStyle? bottomSheetTitle =GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: ColorsManager.white);
  static TextStyle? hintStyle =GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w400,color: ColorsManager.white);
  static TextStyle? dateLabelStyle =GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w400,color: ColorsManager.grey);
  static TextStyle? dateStyle =GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w400,color: ColorsManager.white);
  static TextStyle? taskStyle =GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: ColorsManager.blue,);
  static TextStyle? taskDescriptionStyle =GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal, color: ColorsManager.white,);
  static TextStyle? taskDate =GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.normal, color: ColorsManager.white,);
  static TextStyle? settingsHead =GoogleFonts.poppins(color: ColorsManager.white, fontSize: 16, fontWeight: FontWeight.w700,);
  static TextStyle? settingsSelectedTitle =GoogleFonts.inter(color: ColorsManager.blue, fontSize: 14, fontWeight: FontWeight.w400,);
  static TextStyle? calenderSelectedItem = GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w700, color: ColorsManager.blue);
  static TextStyle? calenderUnSelectedItem = GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w700, color: ColorsManager.white);
  static TextStyle? title = GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: ColorsManager.white);
  static TextStyle? hintTitle = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w300, color: ColorsManager.black.withOpacity(0.7));
  static TextStyle? buttonTitle = GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: ColorsManager.blue);
  static TextStyle? textButtonTitle = GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsManager.white);
  static TextStyle? taskDone = GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: ColorsManager.green);
}