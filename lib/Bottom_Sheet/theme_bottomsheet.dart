import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Theme/app-colors.dart';
import 'package:todo/Providers/my_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: provider.appTheme == ThemeMode.dark
            ? AppColor.DarchPraimaryColor
            : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "select_theme".tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColor.PraimaryColor),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.light);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "light".tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  provider.appTheme == ThemeMode.dark
                      ? SizedBox()
                      : Icon(
                          Icons.done,
                          size: 35,
                          color: AppColor.PraimaryColor,
                        )
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.dark);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "dark".tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  provider.appTheme == ThemeMode.light
                      ? SizedBox()
                      : Icon(
                          Icons.done,
                          size: 35,
                          color: AppColor.PraimaryColor,
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
