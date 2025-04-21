import 'package:get/get.dart';
import 'package:real_estate_app/controllers/home.controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController());
  }
}