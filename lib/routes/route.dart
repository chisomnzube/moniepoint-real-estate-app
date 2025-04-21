import 'package:get/get.dart';
import 'package:real_estate_app/bindings/home.binding.dart';
import 'package:real_estate_app/screens/home/home.dart';
import 'package:real_estate_app/screens/search/search.dart';

List<GetPage<dynamic>> pages = [
  GetPage(
    name: HomeScreen.routeName,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: SearchScreen.routeName,
    page: () => SearchScreen(),
    binding: HomeBinding(),
  ),
];
