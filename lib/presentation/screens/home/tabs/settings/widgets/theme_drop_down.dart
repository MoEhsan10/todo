import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_dark_styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';

import '../../../../../../core/utils/app_light_Styles.dart';
import '../../../../../../providers/theme_provider.dart';

class ThemeDropDown extends StatefulWidget {
  const ThemeDropDown({super.key});

  @override
  State<ThemeDropDown> createState() => _ThemeDropDownState();
}

class _ThemeDropDownState extends State<ThemeDropDown> {
  late String selectedMode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localizations = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    selectedMode = themeProvider.isLightTheme()
        ? localizations.light
        : localizations.dark;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    List<String> themeList = [
      localizations.light,
      localizations.dark,
    ];
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isLight = themeProvider.isLightTheme();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.theme,
          style: isLight ? ApplightStyle.settingsHead : AppDarkStyles.settingsHead,
        ),
        SizedBox(height: 17.h),
        DropdownButtonFormField<String>(
          value: selectedMode,
          decoration: InputDecoration(
            filled: true,
            fillColor: isLight ? ColorsManager.white : ColorsManager.darkBLue,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          ),
          style: TextStyle(
            color: ColorsManager.blue,
            fontSize: 16.sp,
          ),
          dropdownColor: isLight ? ColorsManager.white : ColorsManager.darkBLue,
          items: themeList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: isLight ? ApplightStyle.settingsSelectedTitle : AppDarkStyles.settingsSelectedTitle,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedMode = newValue!;
            });

            if (newValue == localizations.light) {
              themeProvider.changeAppTheme(ThemeMode.light);
            } else {
              themeProvider.changeAppTheme(ThemeMode.dark);
            }
          },
        ),
      ],
    );
  }
}
