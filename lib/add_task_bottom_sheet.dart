import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/app-colors.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/my_provider.dart';
import 'package:todo/taskmodel.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomShhetState();
}

class _AddTaskBottomShhetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var supTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: provider.appTheme == ThemeMode.dark
            ? AppColor.buttonbarColor
            : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'add-title'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: provider.appTheme == ThemeMode.dark
                        ? AppColor.PraimaryColor
                        : Colors.black,
                  ),
                ),
                label: Text('task-t'.tr()),
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: provider.appTheme == ThemeMode.dark
                        ? AppColor.PraimaryColor
                        : Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            TextFormField(
              controller: supTitleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: provider.appTheme == ThemeMode.dark
                        ? AppColor.PraimaryColor
                        : Colors.black,
                  ),
                ),
                label: Text('task-d'.tr()),
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: provider.appTheme == ThemeMode.dark
                        ? AppColor.PraimaryColor
                        : Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "time".tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                SelectedDate();
              },
              child: Text(
                selectedDate.toString().substring(0, 10),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                TaskModel task = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    supTitle: supTitleController.text,
                    date: DateUtils.dateOnly(selectedDate)
                        .microsecondsSinceEpoch);
                FirebaseFunctions.addTask(task).then((value) {
                  Navigator.pop(context);
                });
              },
              child: Text(
                'add-task'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5D9CEC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  SelectedDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xff5D9CEC), // header background color
              ),
            ),
            child: child!,
          );
        });
    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
}
