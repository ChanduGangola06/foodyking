import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodyking/app/data/models/response/coupon_check_model.dart';
import 'package:foodyking/utils/api_list.dart';
import 'package:foodyking/widget/custom_snackbar.dart';
import 'package:get/get.dart';
import '../api/server.dart';

class AuthRepo {
  Server server = Server();
  CouponCheckModel couponCheckModel = CouponCheckModel();

  Future<CouponCheckModel?> checkCoupon(
      {String? email, String? password}) async {
    Map body = {'total': email, 'code': password};
    String jsonBody = json.encode(body);
    try {
      server
          .postRequest(endPoint: APIList.checkCoupon, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          couponCheckModel = CouponCheckModel.fromJson(jsonResponse);
          return couponCheckModel;
        } else {
          customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, Colors.red);
          return null;
        }
      });
      return couponCheckModel;
    } catch (e) {
      return null;
    }
  }
}
