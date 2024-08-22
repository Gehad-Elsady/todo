import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Theme/app-colors.dart';
import 'package:todo/Firebase/firebase_functions.dart';
import 'package:todo/Screens/home.dart';
import 'package:todo/Auth/login-page.dart';
import 'package:todo/Providers/my_provider.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = 'signupPage';
  SignUpPage({super.key});
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your username";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your age";
                    }
                    if (int.parse(value) < 20) {
                      return "Sorry at least 20";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Phone";
                    }
                    if (value.length != 11) {
                      return "Please enter valid Phone";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your emailAddress";
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);

                    if (!emailValid) {
                      return " pLease enter valid email";
                    }

                    return null;
                  },
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
                  validator: (value) {
                    // Improved RegEx for password validation
                    final RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (!regex.hasMatch(value)) {
                      return 'Password must include an uppercase letter, a number, and a special character';
                    }
                    return null;
                  },
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: provider.appTheme == ThemeMode.dark
                            ? AppColor
                                .PraimaryColor // Fixed typo from PraimaryColor to PrimaryColor
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
                    if (formKey.currentState!.validate()) {
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
                    }
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
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName);
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
      ),
    );
  }
}
