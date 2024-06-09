import 'package:foodyking/app/data/api/server.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  static Server server = Server();
  final box = GetStorage();
  bool loader = false;
  bool orderDetailsLoader = false;
}
