import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/Taps/setting_tap.dart';
import 'package:todo/Taps/tasks_tap.dart';
import 'package:todo/add_task_bottom_sheet.dart';

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
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('app-title'.tr()),
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
