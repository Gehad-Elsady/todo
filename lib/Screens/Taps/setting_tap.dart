import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Theme/app-colors.dart';
import 'package:todo/Bottom_Sheet/language_bottomsheet.dart';
import 'package:todo/Providers/my_provider.dart';
import 'package:todo/Bottom_Sheet/theme_bottomsheet.dart';

class SettingTap extends StatelessWidget {
  static const String routeName = 'SettingTap';

  const SettingTap({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "theme".tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.white,
                builder: (context) {
                  return ThemeBottomSheet();
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColor.PraimaryColor),
              ),
              child: provider.appTheme != ThemeMode.dark
                  ? Text(
                      "light".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColor.PraimaryColor),
                    )
                  : Text(
                      "dark".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColor.PraimaryColor),
                    ),
            ),
          ),
          SizedBox(height: 40),
          Text(
            "language".tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.white,
                builder: (context) {
                  return LanguageBottomSheet();
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColor.PraimaryColor)),
              child: context.locale == Locale("ar")
                  ? Text(
                      "arabic".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColor.PraimaryColor),
                    )
                  : Text(
                      "english".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColor.PraimaryColor),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
