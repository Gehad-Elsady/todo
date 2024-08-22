import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/check-user.dart';
import 'package:todo/Theme/app-colors.dart';
import 'package:todo/Firebase/firebase_functions.dart';
import 'package:todo/Screens/home.dart';
import 'package:todo/Providers/my_provider.dart';
import 'package:todo/Auth/signup-page.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'loginpage';
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var user = Provider.of<CheckUser>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/logo-removebg-preview.png"),
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
                  hintText: "e-email".tr(),
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
                height: 30,
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
                  hintText: "e-password".tr(),
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
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFunctions.Login(onSuccess: () async {
                    user.initUser();
                    await Future.delayed(Duration(milliseconds: 500));
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                  }, onError: (e) {
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
                  }, emailController.text, passwordController.text);
                },
                child: Text(
                  'login'.tr(),
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
                  Navigator.pushReplacementNamed(context, SignUpPage.routeName);
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: "d-acc".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 15),
                    children: [
                      TextSpan(
                        text: "signup".tr(),
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
