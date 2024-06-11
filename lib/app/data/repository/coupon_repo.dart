import 'dart:convert';
import 'package:foodyking/app/data/models/response/coupon_check_model.dart';
import 'package:foodyking/app/data/models/response/coupon_model.dart';
import 'package:foodyking/utils/api_list.dart';
import '../api/server.dart';

class CouponRepo {
  static Server server = Server();
  CouponCheckModel couponCheckModel = CouponCheckModel();
  static CouponModel couponModelData = CouponModel();

  static Future<CouponModel?> getCoupon() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.couponList,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          couponModelData = CouponModel.fromJson(jsonResponse);
          return couponModelData;
        }
      });
      return couponModelData;
    } catch (e) {
      return null;
    }
  }
}
