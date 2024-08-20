import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Theme/app-theme.dart';
import 'package:todo/Firebase/firebase_options.dart';
import 'package:todo/Screens/home.dart';
import 'package:todo/Auth/login-page.dart';
import 'package:todo/Providers/my_provider.dart';
import 'package:todo/Auth/signup-page.dart';
import 'package:todo/Screens/updatetask.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      saveLocale: true,
      startLocale: Locale("en"),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MyProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, child) {
      return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        themeMode: provider.appTheme,
        theme: AppTheming.LightTheme,
        darkTheme: AppTheming.DarckTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          UpdateTask.routeName: (context) => UpdateTask(),
          LoginPage.routeName: (context) => LoginPage(),
          SignUpPage.routeName: (context) => SignUpPage()
        },
      );
    });
  }
}
