import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/check-user.dart';
import 'package:todo/Screens/Taps/setting_tap.dart';
import 'package:todo/Screens/Taps/tasks_tap.dart';
import 'package:todo/Bottom_Sheet/add_task_bottom_sheet.dart';
import 'package:todo/Firebase/firebase_functions.dart';
import 'package:todo/Auth/login-page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Widget> taps = [TasksTap(), SettingTap()];

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CheckUser>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text.rich(TextSpan(
          children: [
            TextSpan(
              text: 'app-title'.tr(),
            ),
            TextSpan(
              text: ' ${user.userModel?.name}',
            ),
          ],
        )),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseFunctions.signOut();
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskBottomSheet(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
            elevation: 0,
            // backgroundColor: Colors.transparent,
            currentIndex: selectedIndex,
            onTap: (value) {
              selectedIndex = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'settings-navigation'.tr(),
              ),
            ]),
      ),
      body: taps[selectedIndex],
    );
  }
}
