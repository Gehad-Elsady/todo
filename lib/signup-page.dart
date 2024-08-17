import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app-colors.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/home.dart';
import 'package:todo/login-page.dart';
import 'package:todo/my_provider.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = 'signupPage';
  SignUpPage({super.key});
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 80,
              ),
              Icon(
                Icons.person_add,
                size: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'signup'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: provider.appTheme == ThemeMode.dark
                          ? AppColor.PraimaryColor
                          : Colors.black,
                    ),
                  ),
                  hintText: "name".tr(),
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: provider.appTheme == ThemeMode.dark
                          ? AppColor.PraimaryColor
                          : Colors.black,
                    ),
                  ),
                  hintText: "age".tr(),
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: provider.appTheme == ThemeMode.dark
                          ? AppColor.PraimaryColor
                          : Colors.black,
                    ),
                  ),
                  hintText: "phone".tr(),
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: provider.appTheme == ThemeMode.dark
                          ? AppColor.PraimaryColor
                          : Colors.black,
                    ),
                  ),
                  hintText: "email".tr(),
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: provider.appTheme == ThemeMode.dark
                          ? AppColor.PraimaryColor
                          : Colors.black,
                    ),
                  ),
                  hintText: "password".tr(),
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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFunctions.SignUp(
                    emailController.text,
                    passwordController.text,
                    age: int.parse(ageController.text),
                    userName: nameController.text,
                    phoneNumber: phoneController.text,
                    onSuccess: () {
                      Navigator.pushReplacementNamed(
                          context, HomePage.routeName);
                    },
                    onError: (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'signup'.tr(),
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
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: "h-acc".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 15),
                    children: [
                      TextSpan(
                        text: "login".tr(),
                        style: TextStyle(
                          color: Color(0xff5D9CEC),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
