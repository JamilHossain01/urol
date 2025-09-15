// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:calebshirthum/view/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'common widget/language widget/controller/language_controller.dart';
import 'common widget/language widget/dep.dart' as dep;
import 'common widget/language widget/message.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Get.put(LanguageController()).initStorage();

  Map<String, Map<String, String>> languages = await dep.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MyApp(languages: languages),

    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(languages: languages),
    // ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          translations: Messages(languages: languages),
          fallbackLocale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          home: SplashView(),
          //  home: BottomNavigation(),
        );
      },
    );
  }
}
