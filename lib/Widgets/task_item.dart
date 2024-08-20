import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/Theme/app-colors.dart';
import 'package:todo/Firebase/firebase_functions.dart';
import 'package:todo/Providers/my_provider.dart';
import 'package:todo/Models/taskmodel.dart';
import 'package:todo/Screens/updatetask.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;

  TaskItem({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    Locale currentLocale = context.locale;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      height: 115,
      decoration: BoxDecoration(
        color: provider.appTheme == ThemeMode.dark
            ? AppColor.buttonbarColor
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Slidable(
        // Conditional check for locale
        startActionPane: currentLocale == Locale('en')
            ? ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      FirebaseFunctions.deleteTask(taskModel.id);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'delete'.tr(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.pushNamed(
                        context,
                        UpdateTask.routeName,
                        arguments: taskModel,
                      );
                    },
                    backgroundColor: Color(0xff5D9CEC),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'edit-s'.tr(),
                  ),
                ],
              )
            : null,
        endActionPane: currentLocale != Locale('en')
            ? ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.pushNamed(
                        context,
                        UpdateTask.routeName,
                        arguments: taskModel,
                      );
                    },
                    backgroundColor: Color(0xff5D9CEC),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'edit-s'.tr(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      FirebaseFunctions.deleteTask(taskModel.id);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'delete'.tr(),
                  ),
                ],
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                  color: taskModel.isDone ? Colors.green : Color(0xff5D9CEC),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color:
                            taskModel.isDone ? Colors.green : Color(0xff5D9CEC),
                      ),
                    ),
                    Text(
                      taskModel.supTitle,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              taskModel.isDone
                  ? Text(
                      "done".tr(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Colors.green,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        taskModel.isDone = true;
                        FirebaseFunctions.doneTask(taskModel);
                      },
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 30,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5D9CEC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
