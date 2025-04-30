import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/providers/language_provider.dart';
import '../../../../../../core/utils/app_light_Styles.dart';
import '../../../../../../core/utils/app_dark_styles.dart';
import '../../../../../../providers/theme_provider.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({super.key});

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  final Map<String, String> languageMap = {
    'en': 'english',
    'ar': 'arabic',
  };

  String getLocalizedLabel(String code, AppLocalizations localizations) {
    switch (code) {
      case 'ar':
        return localizations.arabic;
      case 'en':
      default:
        return localizations.english;
    }
  }

  String? getCodeFromLocalizedLabel(String label, AppLocalizations localizations) {
    if (label == localizations.arabic) return 'ar';
    if (label == localizations.english) return 'en';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    final isLight = themeProvider.isLightTheme();
    final localizations = AppLocalizations.of(context)!;

    String selectedLanguageText =
    getLocalizedLabel(languageProvider.currentLanguage, localizations);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.language,
          style: isLight
              ? ApplightStyle.settingsHead
              : AppDarkStyles.settingsHead,
        ),
        SizedBox(height: 17.h),
        DropdownButtonFormField<String>(
          value: selectedLanguageText,
          decoration: InputDecoration(
            filled: true,
            fillColor: isLight ? ColorsManager.white : ColorsManager.darkBLue,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
          ),
          style: TextStyle(
            color: ColorsManager.blue,
            fontSize: 16.sp,
          ),
          dropdownColor:
          isLight ? ColorsManager.white : ColorsManager.darkBLue,
          items: ['en', 'ar'].map((code) {
            return DropdownMenuItem<String>(
              value: getLocalizedLabel(code, localizations),
              child: Text(
                getLocalizedLabel(code, localizations),
                style: isLight
                    ? ApplightStyle.settingsSelectedTitle
                    : AppDarkStyles.settingsSelectedTitle,
              ),
            );
          }).toList(),
          onChanged: (newLabel) {
            final newCode = getCodeFromLocalizedLabel(newLabel!, localizations);
            if (newCode != null) {
              languageProvider.changeAppLanguage(newCode);
            }
          },
        ),
      ],
    );
  }
}
