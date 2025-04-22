import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/controllers/home.controller.dart';
import 'package:real_estate_app/routes/route.dart';
import 'package:real_estate_app/screens/home/home.dart';
import 'package:real_estate_app/utils/constants.dart';
import 'package:real_estate_app/utils/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  await dotenv.load();
  Get.put(HomeController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      getPages: pages,
      initialRoute: HomeScreen.routeName,
      navigatorKey: navigatorKey,
    );
  }
}
