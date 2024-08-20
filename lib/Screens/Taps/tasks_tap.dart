import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/Firebase/firebase_functions.dart';
import 'package:todo/Widgets/task_item.dart';

class TasksTap extends StatefulWidget {
  static const String routeName = 'TasksTap';

  TasksTap({super.key});

  @override
  State<TasksTap> createState() => _TasksTapState();
}

class _TasksTapState extends State<TasksTap> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

    return Column(
      children: [
        CalendarTimeline(
          initialDate: date,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            this.date = date;

            setState(() {});
          },
          leftMargin: 20,
          monthColor: Colors.grey,
          dayColor: Colors.teal[200],
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.blue,
          dotColor: Colors.white,
          selectableDayPredicate: (date) => date.day != 23,
          locale: currentLocale == Locale('en') ? 'en_ISO' : "ar",
        ),
        SizedBox(
          height: 45,
        ),
        StreamBuilder(
            stream: FirebaseFunctions.getTasks(date),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('error'.tr()),
                );
              }
              var tasks = snapshot.data?.docs
                  .map(
                    (doc) => doc.data(),
                  )
                  .toList();
              if (tasks!.isEmpty) {
                return Center(
                  child: Text('error-n'.tr()),
                );
              }
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: tasks[index],
                    );
                  },
                  itemCount: tasks.length,
                ),
              );
            }),
      ],
    );
  }
}
