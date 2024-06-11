import 'package:flutter/cupertino.dart';
import 'package:foodyking/app/controllers/splash_controller.dart';
import 'package:get/get.dart';

import '../data/api/server.dart';
import '../data/models/body/place_order_body.dart';
import '../data/models/response/add_cart_model.dart';
import '../data/models/response/coupon_check_model.dart';
import '../data/repository/coupon_repo.dart';
import 'home_controller.dart';

class CartController extends GetxController {
  bool itemLoader = true;
  List<dynamic> selectedAddOns = [];
  List<int> selectedAddOnsIndex = [];
  List<int> selectedExtraIndex = [];
  List<int> selectedVariationIndex = [];
  List<dynamic> selectedItem = [];
  int selectedSingleVariationIndex = 0;
  List<dynamic>? selectedDish = [];

  int itemQuantity = 1;
  int addOnsQuantity = 1;
  double totalCartValue = 0;
  double deliveryCharge = 0.0;
  double total = 0;
  int orderTypeIndex = 0;

  double totalQunty = 0;
  double kilometer = 0;
  double maxFreeDistance = 0; // in kilometers

  List<MainItem> cartItemList = [];
  List<AddonsItem> addonList = [];
  List<Cart> cart = [];

  //coupon code
  bool couponAplied = false;
  double couponDiscount = 0.0;
  String couponCode = '';
  int? couponId = 0;
  bool couponLoading = false;
  CouponRepo couponRepo = CouponRepo();
  static Server server = Server();
  CouponCheckModel couponCheckModel = CouponCheckModel();
  CouponCheckData couponCheckData = CouponCheckData();
  final TextEditingController couponTextController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  SplashController splash = Get.put(SplashController());

  @override
  void onInit() {
    super.onInit();
  }

  //for main item
  addQuantity() {
    itemQuantity++;
    update();
  }

  removeQuantity() {
    if (itemQuantity > 0) {
      itemQuantity--;
    }
    update();
  }
}
