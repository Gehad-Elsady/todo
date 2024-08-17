import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/app-colors.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/my_provider.dart';
import 'package:todo/taskmodel.dart';

class UpdateTask extends StatefulWidget {
  static const String routeName = 'UpdateTask';
  UpdateTask({super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  DateTime selectedDate = DateTime.now();

  var titleController = TextEditingController();

  var supTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    var model = ModalRoute.of(context)?.settings.arguments as TaskModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('app-title'.tr()),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Container(
              height: 617,
              width: 358,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "edit".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "title".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 20),
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
                              hintText: model.title,
                              hintStyle: Theme.of(context)
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
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "details".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
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
                              hintText: model.supTitle,
                              hintStyle: Theme.of(context)
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
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("time".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          SelectedDate();
                        },
                        child: Text(
                          // DateFormat.yMd(),
                          selectedDate.toString().substring(0, 10),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 20),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          String updatedTitle = titleController.text.isEmpty
                              ? model.title
                              : titleController.text;
                          String updatedSupTitle =
                              supTitleController.text.isEmpty
                                  ? model.supTitle
                                  : supTitleController.text;

                          TaskModel taskUpdate = TaskModel(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            id: model.id,
                            title: updatedTitle,
                            supTitle: updatedSupTitle,
                            date: DateUtils.dateOnly(selectedDate)
                                .microsecondsSinceEpoch,
                          );

                          FirebaseFunctions.updateTask(taskUpdate);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'save'.tr(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff5D9CEC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
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
