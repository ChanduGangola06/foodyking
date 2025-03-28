import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodyking/widget/shimmer/menu_section_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constant.dart';
import '../../../../utils/style.dart';
import '../../../controllers/menu_controller.dart';

Widget homeMenuSection() {
  return GetBuilder<MenuuController>(builder: (menuController) {
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
        menuController.categoryDataList.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                height: 110.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: menuController.categoryDataList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, left: 4.w, right: 10.w, bottom: 10),
                        child: Container(
                          height: 80.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white.withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.searchBarbg,
                                offset: const Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 10.r,
                                spreadRadius: 3.r,
                              ), //BoxShadow
                              //BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 40.w,
                                child: CachedNetworkImage(
                                  imageUrl: menuController
                                      .categoryDataList[index].cover!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                        // colorFilter: ColorFilter.mode(
                                        //     Colors.red, BlendMode.colorBurn),
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        color: Colors.grey),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Center(
                                  child: Text(
                                    menuController.categoryDataList[index].name
                                        .toString(),
                                    style: fontSmallBold,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : MenuSectionShimmer(),
      ],
    );
  });
}
