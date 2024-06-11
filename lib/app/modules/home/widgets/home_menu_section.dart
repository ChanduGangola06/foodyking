import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constant.dart';
import '../../../../utils/style.dart';

Widget homeMenuSection() {
  return Column(
    children: [
      SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "OUR_MENU".tr,
              style: fontBold,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 4.r, horizontal: 8.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColor.viewAllbg,
                ),
                child: Text(
                  "VIEW_ALL".tr,
                  style: fontRegularBoldwithColor,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12.h),
    ],
  );
}
